*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_labor(i)            Regional labor input costs for crop production (mio USD05MER)
 q38_cost_prod_capital(i)          Regional capital input costs for crop production (mio USD05MER)
 q38_investment_immobile(j,kcr)    Cellular immobile investments into farm capital  (mio USD05MER)
 q38_investment_mobile(j)          Cellular mobile investments into farm capital    (mio USD05MER)
;

positive variables
 vm_cost_prod_crop(i,factors)          Regional factor costs of capital and labor for crop production  (mio USD05MER  per yr)
 v38_investment_immobile(j,kcr)        Investment costs in immobile farm capital (mio USD05MER per yr)
 v38_investment_mobile(j)              Investment costs in mobile farm capital (mio USD05MER per yr)
;

parameters
 p38_labor_need(t,i,kcr)               Labor input costs per unit of output (USD05MER per ton DM)
 p38_capital_need(t,i,kcr,mobil38)     Capital requirements per unit of output (USD05MER per ton DM)
 p38_capital_immobile(t,j,kcr)         Preexisting immobile capital stocks before investment (mio USD05MER)
 p38_capital_mobile(t,j)               Preexisting mobile capital stocks before investment (mio USD05MER)

 pm_cost_share_crops(t,i,factors)      Capital and labor shares of the regional factor costs for crop production (1)
 p38_share_calibration(i)              Summation factor used to calibrate calculated capital shares with historical values (1)

 p38_croparea_start(j,w,kcr)           Agricultural land initialization area (mio. ha)

 i38_fac_req(t_all,i,kcr)              Factor requirements (USD05MER per tDM)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod_crop(t,i,factors,type)    Regional factor costs of capital and labor for crop production  (mio USD05MER  per yr)
 ov38_investment_immobile(t,j,kcr,type) Investment costs in immobile farm capital (mio USD05MER per yr)
 ov38_investment_mobile(t,j,type)       Investment costs in mobile farm capital (mio USD05MER per yr)
 oq38_cost_prod_labor(t,i,type)         Regional labor input costs for crop production (mio USD05MER)
 oq38_cost_prod_capital(t,i,type)       Regional capital input costs for crop production (mio USD05MER)
 oq38_investment_immobile(t,j,kcr,type) Cellular immobile investments into farm capital  (mio USD05MER)
 oq38_investment_mobile(t,j,type)       Cellular mobile investments into farm capital    (mio USD05MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
