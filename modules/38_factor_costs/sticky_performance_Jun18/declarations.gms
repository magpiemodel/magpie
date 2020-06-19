*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)                   regional factor input costs for plant production (mio USD05MER)
 q38_cost_prod_crop_inv(i)                   regional factor input costs for plant production (mio USD05MER)

 q38_investment_im(j,kcr)                cellular immobile investments into farm capital   (mio USD05MER)
 q38_investment_mobile(j)                cellular mobile investments into farm capital   (mio USD05MER)
q38_investment_immobile(j,kcr)          cellular immobile investments into farm capital   (mio USD05MER)
 q38_investment_annuity_mobile(i)        annualized regional investment costs for farm capital  (mio USD05MER)
 q38_investment_annuity_immobile(i,kcr)  annualized regional investment costs for farm capital  (mio USD05MER)
;

positive variables
vm_cost_prod(i,kall)                      factor costs (mio USD05MER  per yr)
vm_cost_prod_inv(i)                      investment costs
v38_investment_immobile(j,kcr)           investment costs in farm capital (mio USD05MER per yr)
v38_capital_immobile(j,kcr)              capital stock (USD05MER)
v38_investment_mobile(j)                 investment costs in farm capital (mio USD05MER per yr)
v38_capital_mobile(j)                    capital stock (USD05MER)
v38_investment_annuity_immobile(i,kcr)  annualized investment costs in farm immobile capital (mio USD05MER per yr)
v38_investment_annuity_mobile(i)         annualized investment costs in farm mobile capital (mio USD05MER per yr)
;

parameters
  i38_variable_costs(i,kcr)          variable input costs (mio USD05MER per input unit)
  i38_capital_need(i,kcr,mobil38)    capital requirements for farming with tau equal 1 (mio USD05MER)
  i38_annuity_factor(i)              Factor to calculate overall investment
  p38_capital_intensity(t,j,kcr)     immobile capital per tDM (USD05MER per tDM)
  p38_capital_immobile(t,j,kcr)      preexisting capital stocks before investment (mio USD05MER)
  p38_capital_mobile(t,j)            preexisting capital stocks before investment (mio USD05MER)
  p38_ovcosts(t,i)                   Overall factor costs including non-annuitized capital investment (mio USD05MER)
  s38_capitalmax(j)                  Maximum v38_capital_mobile
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)            factor costs (mio USD05MER  per yr)
 ov38_investment(t,j,kcr,mobil38,type)  investment costs in farm capital (mio USD05MER per yr)
 ov38_investment_annuity(t,i,kcr,type)  annualized investment costs in farm capital (mio USD05MER per yr)
 ov38_capital(t,j,kcr,mobil38,type)     capital stock (USD05MER)
 oq38_cost_prod_crop(t,i,kcr,type)      regional factor input costs for plant production (mio USD05MER)
 oq38_investment(t,j,kcr,mobil38,type)  cellular mobile investments into farm capital   (mio USD05MER)
 oq38_investment_immobile(t,j,kcr,type) cellular immobile investments into farm capital  (mio USD05MER)
 oq38_investment_annuity(t,i,kcr,type)  annualized regional investment costs for farm capital  (mio USD05MER)
 oq38_capital_relocation(t,j,type)      reallocation of mobile capital (mio USD05MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
