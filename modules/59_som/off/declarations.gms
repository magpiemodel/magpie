*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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

