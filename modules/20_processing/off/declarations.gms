*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



positive variables
  vm_dem_processing(i,kall)          demand for processing use
  vm_processing_costs(i)            costs of food processing
  vm_secondary_overproduction(i,kall,kpr) overproduction of secondary couple products (Mt Dm)  
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_processing(t,i,kall,type) demand for processing use
 ov_processing_costs(t,i,type)    costs of food processing
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################