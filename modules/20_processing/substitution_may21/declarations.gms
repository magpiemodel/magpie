*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i20_processing_shares(t_all,i,ksd,kpr)         Shares of secondary products coming from a primary product (1)
 i20_processing_conversion_factors(t_all,processing20,ksd,kpr) Conversion factors of primary products into secondary products (1)
 i20_processing_unitcosts(ksd,kpr)          Costs of transforming x units kpr into 1 unit ksd (USD05MER per tDM)
 ;


positive variables
  vm_dem_processing(i,kall)                      Demand for processing use (mio. tDM per yr)
  v20_dem_processing(i,processing_subst20,kpr)   Demand for processing use by process (mio. tDM per yr)
  v20_secondary_substitutes(i,ksd,kpr)           Substitutes for inferior secondary products (mio. tDM per yr)
  vm_secondary_overproduction(i,kall,kpr)        Overproduction of secondary couple products (mio. tDM per yr)
  vm_cost_processing(i)                          Processing costs (mio. USD05MER per yr)
;

variables
  vm_processing_substitution_cost(i)             Costs or benefits of substituting one product by another (mio. USD05MER per yr)
;

equations
     q20_processing(i,kpr,ksd)                          Processing equation (mio. tDM per yr)
     q20_processing_aggregation_nocereals(i,kpr)        Connecting processing activity to processing flows (mio. tDM per yr)
     q20_processing_aggregation_cereals(i,kcereals20)   Connecting processing activity to food use for milling (mio. tDM per yr)
     q20_processing_aggregation_cotton(i)               Connecting processing activity to production for cotton ginning (mio. tDM per yr)
     q20_processing_substitution_oils(i)                Substitution of oils by other oils (mio. tDM per yr)
     q20_processing_substitution_brans(i)               Substitution of brans by cereals (mio. tNr per yr)
     q20_processing_substitution_sugar(i)               Substitution of molasses by sugar (mio. tDM per yr)
     q20_processing_substitution_protein(i)             Substitution of protein products by other protein products (mio. tNr per yr)
     q20_processing_costs(i)                            Processing costs (mio. USD05MER per yr)
     q20_substitution_utility_loss(i)                  Utility loss when one product has to be substituted by another (mio. t Nr per year)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_processing(t,i,kall,type)                         Demand for processing use (mio. tDM per yr)
 ov20_dem_processing(t,i,processing_subst20,kpr,type)     Demand for processing use by process (mio. tDM per yr)
 ov20_secondary_substitutes(t,i,ksd,kpr,type)             Substitutes for inferior secondary products (mio. tDM per yr)
 ov_secondary_overproduction(t,i,kall,kpr,type)           Overproduction of secondary couple products (mio. tDM per yr)
 ov_cost_processing(t,i,type)                             Processing costs (mio. USD05MER per yr)
 ov_processing_substitution_cost(t,i,type)                Costs or benefits of substituting one product by another (mio. USD05MER per yr)
 oq20_processing(t,i,kpr,ksd,type)                        Processing equation (mio. tDM per yr)
 oq20_processing_aggregation_nocereals(t,i,kpr,type)      Connecting processing activity to processing flows (mio. tDM per yr)
 oq20_processing_aggregation_cereals(t,i,kcereals20,type) Connecting processing activity to food use for milling (mio. tDM per yr)
 oq20_processing_aggregation_cotton(t,i,type)             Connecting processing activity to production for cotton ginning (mio. tDM per yr)
 oq20_processing_substitution_oils(t,i,type)              Substitution of oils by other oils (mio. tDM per yr)
 oq20_processing_substitution_brans(t,i,type)             Substitution of brans by cereals (mio. tNr per yr)
 oq20_processing_substitution_sugar(t,i,type)             Substitution of molasses by sugar (mio. tDM per yr)
 oq20_processing_substitution_protein(t,i,type)           Substitution of protein products by other protein products (mio. tNr per yr)
 oq20_processing_costs(t,i,type)                          Processing costs (mio. USD05MER per yr)
 oq20_substitution_utility_loss(t,i,type)                 Utility loss when one product has to be substituted by another (mio. t Nr per year)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
