*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)         regional factor input costs for plant production (mio USD05MER)
 q38_investment(j,kcr,mobil38)   cellular mobile investments into farm capital   (mio USD05MER)
 q38_investment_immobile(j,kcr)   cellular immobile investments into farm capital  (mio USD05MER)
 q38_investment_annuity(i,kcr) annualized regional investment costs for farm capital  (mio USD05MER)
 q38_capital_relocation(j)   reallocation of mobile capital (mio USD05MER)
 q38_capital_sunk(j,kcr) immobile capital (mio USD05MER)
 q38_crop_change(j,kcr) change in crop patterns (mio ha)
 ;

positive variables
 vm_cost_prod(i,kall)                          factor costs (mio USD05MER  per yr)
 v38_investment(j,kcr,mobil38)                investment costs in farm capital (mio USD05MER per yr)
 v38_investment_annuity(i,kcr)      annualized investment costs in farm capital (mio USD05MER per yr)
 v38_mi(i)      management intensity (share of max yield)
 v38_capital(j,kcr,mobil38)   capital stock (USD05MER)
;

variables
v38_crop_change(j,kcr) change in crop patterns (mio ha);

parameters
 i38_variable_costs(i,kcr) variable input costs (mio USD05MER per input unit)
 p38_capital(t,j,kcr,mobil38) preexisting capital stocks before investment (mio USD05MER)
 p38_capital_intensity(t,j,kcr) immobile capital per tDM (USD05MER per tDM)
 i38_capital_need(i,kcr,mobil38) capital requirements for farming with tau equal 1 (USD05MER)
 p38_investment(j,kcr,mobil38)    investment costs in farm capital of previous period (mio USD05MER)
 p38_past_annuity(i,kcr) investment annuity from previous years
 p38_past_area(j,kcr) previous areas
* p38_annuity_t stores the annuity values for each time step
* p38_ind auxiliar used for cummulative calculation of past annuities in the constrained annuity time horizon
* p38_ind2 auxiliar used for cummulative calculation of past annuities in the constrained annuity time horizon
* p38_ind3 auxiliar used for cummulative calculation of past annuities in the constrained annuity time horizon
 p38_ovcosts(t,i,kcr) overall accumulated factor costs
 p38_accum_ann(t,i,kcr) accumulated annuity
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)            factor costs (mio USD05MER  per yr)
 ov38_investment(t,j,kcr,mobil38,type)  investment costs in farm capital (mio USD05MER per yr)
 ov38_investment_annuity(t,i,kcr,type)  annualized investment costs in farm capital (mio USD05MER per yr)
 ov38_mi(t,i,type)                      management intensity (share of max yield)
 ov38_capital(t,j,kcr,mobil38,type)     capital stock (USD05MER)
 ov38_crop_change(t,j,kcr,type)         change in crop patterns (mio ha)
 oq38_cost_prod_crop(t,i,kcr,type)      regional factor input costs for plant production (mio USD05MER)
 oq38_investment(t,j,kcr,mobil38,type)  cellular mobile investments into farm capital   (mio USD05MER)
 oq38_investment_immobile(t,j,kcr,type) cellular immobile investments into farm capital  (mio USD05MER)
 oq38_investment_annuity(t,i,kcr,type)  annualized regional investment costs for farm capital  (mio USD05MER)
 oq38_capital_relocation(t,j,type)      reallocation of mobile capital (mio USD05MER)
 oq38_capital_sunk(t,j,kcr,type)        immobile capital (mio USD05MER)
 oq38_crop_change(t,j,kcr,type)         change in crop patterns (mio ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
