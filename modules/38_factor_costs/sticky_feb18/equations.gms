*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


* The factor costs split in two parts:
* a) variable costs such as labour inputs
* b) investment costs for capital stocks.

q38_cost_prod_crop(i2,kcr) .. vm_cost_prod(i2,kcr)
                              =e= vm_prod_reg(i2,kcr) * i38_variable_costs(i2,kcr) / (1-v38_mi(i2))
                                  + v38_investment_annuity(i2,kcr);

* Each cropping activity requires a certain capital stock that depends on the
* production. These investments are assumed to be sunk costs.
* Two constraints are needed to calculate new investments.
* The following makes sure that new land expansion has to be equipped
* with capital stock, and that depreciation is replaced.

q38_investment(j2,kcr,mobil38) .. v38_investment(j2,kcr,mobil38)
                                 =g=
                                sum(cell(i2,j2), vm_prod(j2,kcr) * i38_capital_need(i2,kcr,mobil38))
                                 - v38_capital(j2,kcr,mobil38);

* Relocation of mobile capital between crops is possible between crops,
* and between exisiting cropland and new cropland within a cell.
* The latter gives also incentive for expansion in cells with preexisting
* farmland.

 q38_capital_relocation(j2) ..
                          sum(kcr, v38_capital(j2,kcr,"mobile"))
                          =l=
                          sum((kcr,ct), p38_capital(ct,j2,kcr,"mobile"));

* Immobile capital is sunk.
 q38_capital_sunk(j2,kcr) ..
                          v38_capital(j2,kcr,"immobile")
                          =e=
                          sum(ct, p38_capital(ct,j2,kcr,"immobile")+0.00001);

* Also the capital intensity of sunk capital is predetermined.

* q38_investment_immobile(j2,kcr) .. v38_investment(j2,kcr,"immobile")
*                            =g=sum(cell(i2,j2), vm_prod(j2,kcr) *
*                            (i38_capital_need(i2,kcr,"immobile")
*                            - sum(ct, p38_capital_intensity(ct,j2,kcr))));

* Investments are then translated into annual payments using the interest
* and depreciation rates over an infinite time horizon.

 q38_investment_annuity(i2,kcr) ..
                          v38_investment_annuity(i2,kcr)
                          =e=
                          sum((cell(i2,j2),mobil38),
                          v38_investment(j2,kcr,mobil38))*
                          ((1-s38_depreciation_rate)*(pm_interest(i2)/((1+pm_interest(i2))))
							            + s38_depreciation_rate);

*change of crop area
*q38_crop_change(j2,kcr)..
*                        v38_crop_change(j2,kcr)
*                        =e=
*                        sum(w,vm_area(j2,kcr,w))-p38_past_area(j2,kcr);
*                          ;
