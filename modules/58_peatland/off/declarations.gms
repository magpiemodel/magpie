*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_peatland_emis(j) 							GHG emissions from managed peatland (t CO2eq per year)
 vm_peatland_cost(j)							One-time and recurring cost of managed peatland (mio. USD05MER per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_peatland_emis(t,j,type) GHG emissions from managed peatland (t CO2eq per year)
 ov_peatland_cost(t,j,type) One-time and recurring cost of managed peatland (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

