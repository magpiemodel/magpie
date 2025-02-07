*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_labor(i)            Regional labor input costs for crop production (mio USD17MER)
 q38_cost_prod_capital(i)          Regional capital input costs for crop production (mio USD17MER)
 q38_investment_immobile(j,kcr)    Cellular immobile investments into farm capital  (mio USD17MER)
 q38_investment_mobile(j)          Cellular mobile investments into farm capital    (mio USD17MER)
;

positive variables
 vm_cost_prod_crop(i,factors)          Regional factor costs of capital and labor for crop production  (mio USD17MER  per yr)
 v38_investment_immobile(j,kcr)        Investment costs in immobile farm capital (mio USD17MER per yr)
 v38_investment_mobile(j)              Investment costs in mobile farm capital (mio USD17MER per yr)
;

parameters
 p38_labor_need(t,i,kcr)               Labor input costs per unit of output (USD17MER per ton DM)
 p38_capital_need(t,i,kcr,mobil38)     Capital requirements per unit of output (USD17MER per ton DM)
 p38_capital_immobile(t,j,kcr)         Preexisting immobile capital stocks before investment (mio USD17MER)
 p38_capital_mobile(t,j)               Preexisting mobile capital stocks before investment (mio USD17MER)

 p38_capital_cost_shares_iso(t,iso)    Capital shares of factor costs on iso level (1)
 p38_capital_share_calibration(iso)    Summation factor used to calibrate calculated capital shares with historical values (1)
 pm_factor_cost_shares(t,i,factors)    Capital and labor shares of factor costs on regional level (1) 

 p38_croparea_start(j,w,kcr)           Agricultural land initialization area (mio. ha)

 i38_fac_req(t_all,i,kcr)              Factor requirements (USD17MER per tDM)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod_crop(t,i,factors,type)    Regional factor costs of capital and labor for crop production  (mio USD17MER  per yr)
 ov38_investment_immobile(t,j,kcr,type) Investment costs in immobile farm capital (mio USD17MER per yr)
 ov38_investment_mobile(t,j,type)       Investment costs in mobile farm capital (mio USD17MER per yr)
 oq38_cost_prod_labor(t,i,type)         Regional labor input costs for crop production (mio USD17MER)
 oq38_cost_prod_capital(t,i,type)       Regional capital input costs for crop production (mio USD17MER)
 oq38_investment_immobile(t,j,kcr,type) Cellular immobile investments into farm capital  (mio USD17MER)
 oq38_investment_mobile(t,j,type)       Cellular mobile investments into farm capital    (mio USD17MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
