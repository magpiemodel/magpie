*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
q38_cost_prod_crop_labor(i)      Regional labor costs for crop production (mio. USD17MER per yr)
q38_cost_prod_crop_capital(i)    Regional capital costs for crop production (mio. USD17MER per yr)
;

positive variables
vm_cost_prod_crop(i,factors)      Regional factor costs of capital and labor for crop production (mio. USD17MER per yr)
;

parameter
p38_capital_cost_shares_iso(t,iso)    Capital shares of factor costs on iso level (1)
p38_capital_share_calibration(iso)    Summation factor used to calibrate calculated capital shares with historical values (1)
pm_factor_cost_shares(t,i,factors)    Capital and labor shares of factor costs on regional level (1) 
i38_fac_req(t_all,i,kcr)              Factor requirements (USD17MER per tDM)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod_crop(t,i,factors,type)   Regional factor costs of capital and labor for crop production (mio. USD17MER per yr)
 oq38_cost_prod_crop_labor(t,i,type)   Regional labor costs for crop production (mio. USD17MER per yr)
 oq38_cost_prod_crop_capital(t,i,type) Regional capital costs for crop production (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
