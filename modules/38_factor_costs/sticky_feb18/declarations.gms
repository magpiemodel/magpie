*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)         regional factor input costs for plant production
 q38_croparea_investment(j,kcr)   cellular investments into farm capital
 q38_croparea_investment_annuity(i,kcr) annualized regional investment costs for farm capital
;

positive variables
 vm_cost_prod(i,kall)                          factor costs (mio USD)
 v38_croparea_investment(j,kcr)                investment costs in farm capital (mio USD)
 v38_croparea_investment_annuity(i,kcr)      annualized investment costs in farm capital (mio US$)
;

parameters
 p38_croparea_preexisting_capital(t,j,kcr) preexisting capital stocks before investment (mio USD)
 i38_capital_requirement(i,kcr) capital requirements for farming practice (mio USD)
 p38_croparea_investment(j,kcr)    investment costs in farm capital of previous period (mio USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)                    factor costs (mio USD)
 ov38_croparea_investment(t,j,kcr,type)         investment costs in farm capital (mio USD)
 ov38_croparea_investment_annuity(t,i,kcr,type) annualized investment costs in farm capital (mio US$)
 oq38_cost_prod_crop(t,i,kcr,type)              regional factor input costs for plant production
 oq38_croparea_investment(t,j,kcr,type)         cellular investments into farm capital
 oq38_croparea_investment_annuity(t,i,kcr,type) annualized regional investment costs for farm capital
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
