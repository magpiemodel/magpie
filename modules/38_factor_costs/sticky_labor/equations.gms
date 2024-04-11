*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations

*' Constant elasticity of substitution (CES) production function for one unit of output.
*' The CES function accounts for capital `v38_capital_need` and labor `v38_laborhours_need` requirements.
*' The efficiency of labor is affected by the labor productivity factor `pm_labor_prod` based on climate 
*' change impacts, which is provided by the labor productivity module [37_labor_prod], and by the factor 
*' `pm_productivity_gain_from_wages` based on increased wages from [36_employment].
*' The calculation of total capital and labor costs is covered by the equations `q38_cost_prod_crop` and `q38_cost_prod_inv`.
*' The conceptual and analytical details of the CES function including the labor productivity factor are documented in @orlov_ces_2021.

 q38_ces_prodfun(j2,kcr) ..
  i38_ces_scale(j2,kcr) *
  (i38_ces_shr(j2,kcr)*sum(mobil38, v38_capital_need(j2,kcr,mobil38))**(-s38_ces_elast_par) +
  (1 - i38_ces_shr(j2,kcr))*(sum(ct, pm_labor_prod(ct,j2) * sum(cell(i2,j2), pm_productivity_gain_from_wages(ct,i2))) * v38_laborhours_need(j2,kcr))**(-s38_ces_elast_par))**(-1/s38_ces_elast_par)
  =e= 1 + v38_relax_CES_lp(j2,kcr);
  
*' As low labor shares can lead to low agricultural employment, which is not necessarily a desired output, a 
*' minimum share of labor need can be set.

q38_labor_share_target(j2) .. 
  sum(kcr, vm_prod(j2,kcr) * v38_laborhours_need(j2,kcr) * sum((ct, cell(i2,j2)), pm_hourly_costs(ct,i2,"scenario"))) =g=
             sum(ct, p38_min_labor_share(ct,j2)) * 
              (sum(kcr, vm_prod(j2,kcr) * v38_laborhours_need(j2,kcr) * 
                          sum((ct, cell(i2,j2)), pm_hourly_costs(ct,i2,"scenario"))) + 
               sum((mobil38, kcr), vm_prod(j2,kcr) * v38_capital_need(j2,kcr,mobil38)) *
                sum((ct, cell(i2,j2)), pm_interest(ct,i2) + s38_depreciation_rate));

*' Labor costs: The labor costs are calculated by multiplying regional aggregated production with labor requirements 
*' (in hours) per output unit and wages from [36_employment].

q38_cost_prod_labor(i2).. vm_cost_prod_crop(i2,"labor")
                              =e= sum(kcr,sum(cell(i2,j2), vm_prod(j2,kcr) * v38_laborhours_need(j2,kcr) * sum(ct, pm_hourly_costs(ct,i2,"scenario"))))
                                ;

*' Investment costs: Investment are the summation of investment in mobile and immobile capital. The costs are annuitized,
*' and corrected to make sure that the annual depreciation of the current time-step is accounted for.

q38_cost_prod_capital(i2).. vm_cost_prod_crop(i2,"capital")=e=(sum((cell(i2,j2),kcr),v38_investment_immobile(j2,kcr))
                                    +sum((cell(i2,j2)),v38_investment_mobile(j2)))
                                    *((1-s38_depreciation_rate)*
                                    sum(ct,pm_interest(ct,i2)/(1+pm_interest(ct,i2)))
                                        + s38_depreciation_rate)
                                        ;


*' Each cropping activity requires a certain capital stock that depends on the
*' production. The following equations make sure that new land expansion is equipped
*' with capital stock, and that depreciation of pre-existing capital is replaced.
*' Since the mobility of capital is defined over crop-type, immobile capital is set
*' over specific crop types and locations.

q38_investment_immobile(j2,kcr).. v38_investment_immobile(j2,kcr)
                                  =g=
                                 vm_prod(j2,kcr) * v38_capital_need(j2,kcr,"immobile") -
                                 sum(ct, p38_capital_immobile(ct,j2,kcr));
*

*' On the other hand, the mobile capital is needed by all crop activities in each location, so it is defined over each j2 cell.

q38_investment_mobile(j2).. v38_investment_mobile(j2)
                             =g=
                             sum(kcr, vm_prod(j2,kcr) * v38_capital_need(j2,kcr,"mobile")) -
                             sum(ct, p38_capital_mobile(ct,j2));
*
