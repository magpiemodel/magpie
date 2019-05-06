*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

variables
         vm_nr_som(j)                        Release of soil organic matter (Tg N per yr)
         vm_costs_overrate_cropdiff(i)	     Punishment costs for overrated cropland difference (mio. USD05 per yr)  
;
*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_som(t,j,type)                  Release of soil organic matter (Tg N per yr)
 ov_costs_overrate_cropdiff(t,i,type) Punishment costs for overrated cropland difference (mio. USD05 per yr)  
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

