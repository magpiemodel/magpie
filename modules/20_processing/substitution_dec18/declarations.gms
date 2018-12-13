*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



positive variables
  vm_dem_processing(i,kall)                      Demand for processing use (mio. tDM per yr)
  v20_dem_processing(i,processing_subst20,kpr)   Demand for processing use by process (mio. tDM per yr)
  v20_secondary_substitutes(i,ksd,kpr)           Substitutes for inferior secondary products (mio. tDM per yr)
  vm_secondary_overproduction(i,kall,kpr)        Overproduction of secondary couple products (mio. tDM per yr)
  vm_cost_processing(i)                          Processing costs (mio. USD05MER per yr)
;

equations
     q20_processing(i,kpr,ksd)                          Processing equation (mio. tDM per yr)
     q20_processing_aggregation_nocereals(i,kpr)        Connecting processing activity to processing flows (mio. tDM per yr)
     q20_processing_aggregation_cereals(i,kcereals20)   Connecting processing activity to food use for milling (mio. tDM per yr)
     q20_processing_aggregation_cotton(i)               Connecting processing activity to production for cotton ginning (mio. tDM per yr)
     q20_processing_substitution_oils(i)                Substitution of branoils by other oils (mio. tDM per yr)
     q20_processing_substitution_brans(i)               Substitution of brans by cereals (mio. tDM per yr)
     q20_processing_costs(i)                            Processing costs (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_processing(t,i,kall,type)                         Demand for processing use (mio. tDM per yr)
 ov20_dem_processing(t,i,processing_subst20,kpr,type)     Demand for processing use by process (mio. tDM per yr)
 ov20_secondary_substitutes(t,i,ksd,kpr,type)             Substitutes for inferior secondary products (mio. tDM per yr)
 ov_secondary_overproduction(t,i,kall,kpr,type)           Overproduction of secondary couple products (mio. tDM per yr)
 ov_cost_processing(t,i,type)                             Processing costs (mio. USD05MER per yr)
 oq20_processing(t,i,kpr,ksd,type)                        Processing equation (mio. tDM per yr)
 oq20_processing_aggregation_nocereals(t,i,kpr,type)      Connecting processing activity to processing flows (mio. tDM per yr)
 oq20_processing_aggregation_cereals(t,i,kcereals20,type) Connecting processing activity to food use for milling (mio. tDM per yr)
 oq20_processing_aggregation_cotton(t,i,type)             Connecting processing activity to production for cotton ginning (mio. tDM per yr)
 oq20_processing_substitution_oils(t,i,type)              Substitution of branoils by other oils (mio. tDM per yr)
 oq20_processing_substitution_brans(t,i,type)             Substitution of brans by cereals (mio. tDM per yr)
 oq20_processing_costs(t,i,type)                          Processing costs (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
