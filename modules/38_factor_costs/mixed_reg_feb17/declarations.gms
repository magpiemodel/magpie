*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
q38_cost_prod_crop(i,req)      Regional factor costs of capital and labor for plant production (mio. USD05MER per yr)
;


positive variables
vm_cost_prod_crop(i,req)       Regional factor costs of capital and labor for plant production (mio. USD05MER per yr)
;

parameters
p38_fac_req(i,kcr,w)           Regional factor requirement costs differentiated by irrigation type (USD05MER per tDM)
p38_cost_share(t,i,req)        Capital and labor shares of the regional factor costs for plant production   (1)
p38_share_calibration(i)       Summation factor used to calibrate calculated capital shares with historical values (1)

;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod_crop(t,i,req,type)   Regional factor costs of capital and labor for plant production (mio. USD05MER per yr)
 oq38_cost_prod_crop(t,i,req,type) Regional factor costs of capital and labor for plant production (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
