*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_labor(i)            Regional labor input costs for crop production (mio USD05MER)
 q38_cost_prod_capital(i)          Regional capital input costs for crop production (mio USD05MER)
 q38_investment_immobile(j,kcr)    Cellular immobile investments into farm capital   (mio USD05MER)
 q38_investment_mobile(j)          Cellular mobile investments into farm capital   (mio USD05MER)
 q38_ces_prodfun(j,kcr)            CES production function for one unit of output (1)
 q38_labor_share_target(j)         Enforces minimum labor cost share out of factor costs (1)
;

positive variables
 vm_cost_prod_crop(i,factors)          Regional factor costs of capital and labor for crop production  (mio USD05MER  per yr)
 v38_investment_immobile(j,kcr)        Investment costs in immobile farm capital (mio USD05MER per yr)
 v38_investment_mobile(j)              Investment costs in mobile farm capital (mio USD05MER per yr)
 v38_laborhours_need(j,kcr)            Labor required per unit of output (hours per ton DM)
 v38_capital_need(j,kcr,mobil38)       Captial required per unit of output (USD05MER per ton DM)
 v38_relax_CES_lp(j,kcr)               Variable to make CES function feasible in linearized model (1) 
;

parameters
 p38_labor_need(t,i,kcr)               Labor input costs per unit of output (USD05MER per ton DM)
 p38_capital_need(t,i,kcr,mobil38)     Capital requirements per unit of output (USD05MER per ton DM)
 p38_capital_immobile(t,j,kcr)         Preexisting immobile capital stocks before investment (mio USD05MER)
 p38_capital_mobile(t,j)               Preexisting mobile capital stocks before investment (mio USD05MER)

 pm_cost_share_crops(t,i,factors)      Capital and labor shares of the regional factor costs for crop production   (1)
 p38_share_calibration(i)              Summation factor used to calibrate calculated capital shares with historical values (1)
 p38_min_labor_share(t,j)              Minimum labor share out of labor plus capital needed (1)

 p38_croparea_start(j,w,kcr)           Agricultural land initialization area (mio. ha)

 i38_ces_shr(j,kcr)                    Share parameter for CES function (1)
 i38_ces_scale(j,kcr)                  Scaling factor for total factor productivity (1)
 
 p38_intr_depr(t,i)                    Factor from interest and depreciation rate (1)

 i38_fac_req(t_all,i,kcr)              Factor requirements (USD05MER per tDM)
;

scalars
 s38_ces_elast_par                      Elasticity parameter for CES function (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod_crop(t,i,factors,type)     Regional factor costs of capital and labor for crop production  (mio USD05MER  per yr)
 ov38_investment_immobile(t,j,kcr,type)  Investment costs in immobile farm capital (mio USD05MER per yr)
 ov38_investment_mobile(t,j,type)        Investment costs in mobile farm capital (mio USD05MER per yr)
 ov38_laborhours_need(t,j,kcr,type)      Labor required per unit of output (hours per ton DM)
 ov38_capital_need(t,j,kcr,mobil38,type) Captial required per unit of output (USD05MER per ton DM)
 ov38_relax_CES_lp(t,j,kcr,type)         Variable to make CES function feasible in linearized model (1) 
 oq38_cost_prod_labor(t,i,type)          Regional labor input costs for crop production (mio USD05MER)
 oq38_cost_prod_capital(t,i,type)        Regional capital input costs for crop production (mio USD05MER)
 oq38_investment_immobile(t,j,kcr,type)  Cellular immobile investments into farm capital   (mio USD05MER)
 oq38_investment_mobile(t,j,type)        Cellular mobile investments into farm capital   (mio USD05MER)
 oq38_ces_prodfun(t,j,kcr,type)          CES production function for one unit of output (1)
 oq38_labor_share_target(t,j,type)       Enforces minimum labor cost share out of factor costs (1)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
