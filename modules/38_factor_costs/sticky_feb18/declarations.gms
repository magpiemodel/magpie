*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)         Regional factor input costs for plant production (mio USD05MER)
 q38_cost_prod_inv(i)              Regional investment costs in capital (mio USD05MER)
 q38_investment_immobile(j,kcr)    Cellular immobile investments into farm capital   (mio USD05MER)
 q38_investment_mobile(j)          Cellular mobile investments into farm capital   (mio USD05MER)
;

positive variables
 vm_cost_prod(i,kall)                  Factor costs  (mio USD05MER  per yr)
 vm_cost_inv(i)                        Investment capital costs (mio USD05MER  per yr)
 v38_investment_immobile(j,kcr)        Investment costs in immobile farm capital (mio USD05MER per yr)
 v38_investment_mobile(j)              Investment costs in mobile farm capital (mio USD05MER per yr)
;

parameters
 i38_variable_costs(i,kcr)           Variable input costs (mio USD05MER per input unit)
 i38_capital_need(i,kcr,mobil38)     Capital requirements for farming with tau equal 1 (mio USD05MER)
 p38_capital_immobile(t,j,kcr)       Preexisting immobile capital stocks before investment (mio USD05MER)
 p38_capital_mobile(t,j)             Preexisting mobile capital stocks before investment (mio USD05MER)
 ;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)            factor costs  (mio USD05MER  per yr)
 ov_cost_inv(t,i,type)                  investment capital costs (mio USD05MER  per yr)
 ov38_investment_immobile(t,j,kcr,type) investment costs in immobile farm capital (mio USD05MER per yr)
 ov38_investment_mobile(t,j,type)       investment costs in mobile farm capital (mio USD05MER per yr)
 ov38_capital_immobile(t,j,kcr,type)    immobile capital stock (USD05MER)
 ov38_capital_mobile(t,j,type)          mobile capital stock (USD05MER)
 oq38_cost_prod_crop(t,i,kcr,type)      regional factor input costs for plant production (mio USD05MER)
 oq38_cost_prod_inv(t,i,type)           regional investment costs in capital (mio USD05MER)
 oq38_investment_immobile(t,j,kcr,type) cellular immobile investments into farm capital   (mio USD05MER)
 oq38_investment_mobile(t,j,type)       cellular mobile investments into farm capital   (mio USD05MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
