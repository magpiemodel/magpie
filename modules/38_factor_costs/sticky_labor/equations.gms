*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations

*' Constant elasticity of substitution (CES) production function for one unit of output.
*' The CES function accounts for capital `v38_capital_need` and labor `v38_labor_need` requirements.
*' The efficiency of labor is affected by the labor productivity factor `vm_labor_prod`, which is 
*' provided by the labor productivity module [37_labor_prod].
*' The calculation of total capital and labor costs is covered by the equations `q38_cost_prod_crop` and `q38_cost_prod_inv`.
*' The conceptual and analytical details of the CES function including the labor productivity factor are documented in @orlov_ces_2021.

 q38_ces_prodfun(j2,kcr) ..
  i38_ces_scale(j2,kcr) * 
  (i38_ces_shr(j2,kcr)*sum(mobil38, v38_capital_need(j2,kcr,mobil38))**(-s38_ces_elast_par) + 
  (1 - i38_ces_shr(j2,kcr))*(sum(ct, pm_labor_prod(ct,j2)) * v38_labor_need(j2,kcr))**(-s38_ces_elast_par))**(-1/s38_ces_elast_par)
  =e= 1 ;

*' Variable labor costs (without capital): The labor costs are calculated based on the 
*' requirements of the cellular production without considering capital costs.

q38_cost_prod_crop(i2,kcr).. vm_cost_prod(i2,kcr)
                              =e= sum(cell(i2,j2), vm_prod(j2,kcr) * v38_labor_need(j2,kcr) * s38_wage)
                                ;

*' Investment costs: Investment are the summation of investment in mobile and immobile capital. The costs are annuitized,
*' and corrected to make sure that the annual depreciation of the current time-step is accounted for.

q38_cost_prod_inv(i2).. vm_cost_inv(i2)=e=(sum((cell(i2,j2),kcr),v38_investment_immobile(j2,kcr))
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
