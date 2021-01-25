*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations
*' Variable costs (without capital): The factor costs are calculated based on the requirements  of the regional aggregated production without
* considering capital costs.

q38_cost_prod_crop(i2,kcr).. vm_cost_prod(i2,kcr)
                              =e= vm_prod_reg(i2,kcr) * i38_variable_costs(i2,kcr) / (1-s38_mi_start)
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
                                 sum(cell(i2,j2),vm_prod(j2,kcr)*i38_capital_need(i2,kcr,"immobile"))
                                 - sum(ct,p38_capital_immobile(ct,j2,kcr));

*'On the other hand, the mobile capital is needed by all crop activities in each location, so it is defined over each j2 cell.

q38_investment_mobile(j2).. v38_investment_mobile(j2)
                             =g=
                             sum((cell(i2,j2),kcr),vm_prod(j2,kcr)*i38_capital_need(i2,kcr,"mobile"))
                             -sum(ct,p38_capital_mobile(ct,j2));
