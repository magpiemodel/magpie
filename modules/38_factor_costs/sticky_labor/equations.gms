*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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
                                    + sum((cell(i2,j2)),v38_investment_mobile(j2)))
                                    * sum(ct, (pm_interest(ct, i2) + s38_depreciation_rate) / (1+pm_interest(ct,i2)))
                                    ;

*' The logic behind the annuitization is the following:
*' MAgPIE should do an investment if the utility it gains from this investment over all future timesteps U_0..n exceeds the Investment costs I_0
*' Lets assume the utility is a ratio z of the physical capital stock K, such that 
*' (1) U_t = K_t  * z
*' NOTE: A big assumption is that z is not time-dependent, so we assume that all future periods have the same benefit from the capital stock.

*' The utility in the next timestep, t+1 should be lower, because the capital depreciates, and because future utility is discounted because 
*' of time preference or opportunity costs. The result is
*' (2) U_t+1 = K_t * (1-d) * z / (1+r)
*' next, we want to sum up all utilities from now until forever, so
*' (3) U_0..n = U_0 + U_1 + ... U_n
*' we can enter (2) in (3) to get
*' (4) I_0 <= K_0 * z + K_0 * z*(1-d)/(1+r) + K_0 * z * (1-d)^2 / (1+r)^2 +...+ K_0 * z * (1-d)^n/((1+r)^n) 
*' which is then, based on the gemoetric series above
*' (5) I_0 <= K_0 * z * (1+r) / (r+d) 

*' Now, we have the problem that MAgPIE does not see the future. It only sees the costs and the utility of the current period.
*' In MAgPIE, the invesment is done if the utiltiy of the current period U_0 exceeds the costs it sees in the current period, C_0.
*' We know based on equation (1) that U_0 = K_0 * z, which we can enter into (4) such that
*' (6) I_0 <= U_0 * (1+r) / (r+d) 

*' So, we can compare the investment costs to the utility U_0, the utility that the model gains in the current timestep from making the investement.
*' It should do the investment when 
*' (7) U_0 >= I_0 * (r+d) / (1+r) = C_0
*' The right hand of this equation is therefore the costs C_0 that the model should see to evaluate whether the utility U_0 is sufficient to justify the investment.

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
