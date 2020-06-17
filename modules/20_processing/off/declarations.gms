*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
  q20_processing_costs(i)                        processing costs (mio.USD05MER)
;

positive variables
  vm_dem_processing(i,kall)                      demand for processing use (mio.tDM)
  vm_secondary_overproduction(i,kall,kpr)        overproduction of secondary couple products (mio.tDM)
  vm_cost_processing(i)                          processing costs (mio. USD05MER per yr)
;

variables
  vm_processing_substitution_cost(i)             Costs or benefits of substituting one product by another (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_processing(t,i,kall,type)               demand for processing use (mio.tDM)
 ov_secondary_overproduction(t,i,kall,kpr,type) overproduction of secondary couple products (mio.tDM)
 ov_cost_processing(t,i,type)                   processing costs (mio. USD05MER per yr)
 ov_processing_substitution_cost(t,i,type)      Costs or benefits of substituting one product by another (mio. USD05MER per yr)
 oq20_processing_costs(t,i,type)                processing costs (mio.USD05MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
