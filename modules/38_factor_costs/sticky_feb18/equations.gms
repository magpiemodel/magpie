*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the current realization, factor costs are separated in variable costs and investment
*' costs on capital stocks which can be immobile and mobile. Mobility is defined between crops.

*' @code
*' Variable costs:

q38_cost_prod_crop(i2,kcr).. vm_cost_prod(i2,kcr)
                              =e= vm_prod_reg(i2,kcr) * i38_variable_costs(i2,kcr) / (1-0.47)
                                ;

*' Investment costs
q38_cost_prod_inv(i2).. vm_cost_inv(i2)=e=(sum((cell(i2,j2),kcr),v38_investment_immobile(j2,kcr))
                                    +sum((cell(i2,j2)),v38_investment_mobile(j2)))
                                    *((1-s38_depreciation_rate)*sum(ct,pm_interest(ct,i2)/(1+pm_interest(ct,i2)))
                                        + s38_depreciation_rate)
                                        ;                                ;


*' Each cropping activity requires a certain capital stock that depends on the
*' production. These investments are assumed to be sunk costs.
*' The following makes sure that new land expansion has to be equipped
*' with capital stock, and that depreciation is replaced.

q38_investment_immobile(j2,kcr).. v38_investment_immobile(j2,kcr)
                                  =g=
                                 sum(cell(i2,j2), vm_prod(j2,kcr) * i38_capital_need(i2,kcr,"immobile"))
                                 - v38_capital_immobile(j2,kcr);

q38_investment_mobile(j2).. v38_investment_mobile(j2)
                             =g=
                             sum((cell(i2,j2),kcr), vm_prod(j2,kcr) * i38_capital_need(i2,kcr,"mobile"))
                              - v38_capital_mobile(j2);
