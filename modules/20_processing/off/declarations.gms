*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


equations
  q20_processing_costs(i)    processing costs
;

positive variables
  vm_dem_processing(i,kall)          demand for processing use
  vm_secondary_overproduction(i,kall,kpr) overproduction of secondary couple products (Mt Dm)
  vm_cost_processing(i)            processing costs (Million USD05)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_processing(t,i,kall,type)               demand for processing use
 ov_secondary_overproduction(t,i,kall,kpr,type) overproduction of secondary couple products (Mt Dm)
 ov_cost_processing(t,i,type)                   processing costs (Million USD05)
 oq20_processing_costs(t,i,type)                processing costs
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
