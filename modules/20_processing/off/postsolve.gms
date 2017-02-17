*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_processing(t,i,kall,"marginal") = vm_dem_processing.m(i,kall);
 ov_processing_costs(t,i,"marginal")    = vm_processing_costs.m(i);
 ov_dem_processing(t,i,kall,"level")    = vm_dem_processing.l(i,kall);
 ov_processing_costs(t,i,"level")       = vm_processing_costs.l(i);
 ov_dem_processing(t,i,kall,"upper")    = vm_dem_processing.up(i,kall);
 ov_processing_costs(t,i,"upper")       = vm_processing_costs.up(i);
 ov_dem_processing(t,i,kall,"lower")    = vm_dem_processing.lo(i,kall);
 ov_processing_costs(t,i,"lower")       = vm_processing_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
