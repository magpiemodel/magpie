*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
q38_cost_prod_crop(i,req)      Regional factor input costs for plant production (mio. USD05MER per yr)
;

positive variables
vm_cost_prod_crop(i,req)        Crop factor costs (mio. USD05MER per yr)
;

parameter
p38_cost_share(t,i,req)       Capital anad labor shares  (1)
p38_share_calibration(i)      Summation factor used to calibrate calculated capital shares with historical values (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)       Factor costs (mio. USD05MER per yr)
 ov_cost_inv(t,i,type)             Capital investment costs (mio USD05MER  per yr)
 oq38_cost_prod_crop(t,i,kcr,type) Regional factor input costs for plant production (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################