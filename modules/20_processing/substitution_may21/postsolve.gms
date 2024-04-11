*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_processing(t,i,kall,"marginal")                         = vm_dem_processing.m(i,kall);
 ov20_dem_processing(t,i,processing_subst20,kpr,"marginal")     = v20_dem_processing.m(i,processing_subst20,kpr);
 ov20_secondary_substitutes(t,i,ksd,kpr,"marginal")             = v20_secondary_substitutes.m(i,ksd,kpr);
 ov_secondary_overproduction(t,i,kall,kpr,"marginal")           = vm_secondary_overproduction.m(i,kall,kpr);
 ov_cost_processing(t,i,"marginal")                             = vm_cost_processing.m(i);
 ov_processing_substitution_cost(t,i,"marginal")                = vm_processing_substitution_cost.m(i);
 oq20_processing(t,i,kpr,ksd,"marginal")                        = q20_processing.m(i,kpr,ksd);
 oq20_processing_aggregation_nocereals(t,i,kpr,"marginal")      = q20_processing_aggregation_nocereals.m(i,kpr);
 oq20_processing_aggregation_cereals(t,i,kcereals20,"marginal") = q20_processing_aggregation_cereals.m(i,kcereals20);
 oq20_processing_aggregation_cotton(t,i,"marginal")             = q20_processing_aggregation_cotton.m(i);
 oq20_processing_substitution_oils(t,i,"marginal")              = q20_processing_substitution_oils.m(i);
 oq20_processing_substitution_brans(t,i,"marginal")             = q20_processing_substitution_brans.m(i);
 oq20_processing_substitution_sugar(t,i,"marginal")             = q20_processing_substitution_sugar.m(i);
 oq20_processing_substitution_protein(t,i,"marginal")           = q20_processing_substitution_protein.m(i);
 oq20_processing_costs(t,i,"marginal")                          = q20_processing_costs.m(i);
 oq20_substitution_utility_loss(t,i,"marginal")                 = q20_substitution_utility_loss.m(i);
 ov_dem_processing(t,i,kall,"level")                            = vm_dem_processing.l(i,kall);
 ov20_dem_processing(t,i,processing_subst20,kpr,"level")        = v20_dem_processing.l(i,processing_subst20,kpr);
 ov20_secondary_substitutes(t,i,ksd,kpr,"level")                = v20_secondary_substitutes.l(i,ksd,kpr);
 ov_secondary_overproduction(t,i,kall,kpr,"level")              = vm_secondary_overproduction.l(i,kall,kpr);
 ov_cost_processing(t,i,"level")                                = vm_cost_processing.l(i);
 ov_processing_substitution_cost(t,i,"level")                   = vm_processing_substitution_cost.l(i);
 oq20_processing(t,i,kpr,ksd,"level")                           = q20_processing.l(i,kpr,ksd);
 oq20_processing_aggregation_nocereals(t,i,kpr,"level")         = q20_processing_aggregation_nocereals.l(i,kpr);
 oq20_processing_aggregation_cereals(t,i,kcereals20,"level")    = q20_processing_aggregation_cereals.l(i,kcereals20);
 oq20_processing_aggregation_cotton(t,i,"level")                = q20_processing_aggregation_cotton.l(i);
 oq20_processing_substitution_oils(t,i,"level")                 = q20_processing_substitution_oils.l(i);
 oq20_processing_substitution_brans(t,i,"level")                = q20_processing_substitution_brans.l(i);
 oq20_processing_substitution_sugar(t,i,"level")                = q20_processing_substitution_sugar.l(i);
 oq20_processing_substitution_protein(t,i,"level")              = q20_processing_substitution_protein.l(i);
 oq20_processing_costs(t,i,"level")                             = q20_processing_costs.l(i);
 oq20_substitution_utility_loss(t,i,"level")                    = q20_substitution_utility_loss.l(i);
 ov_dem_processing(t,i,kall,"upper")                            = vm_dem_processing.up(i,kall);
 ov20_dem_processing(t,i,processing_subst20,kpr,"upper")        = v20_dem_processing.up(i,processing_subst20,kpr);
 ov20_secondary_substitutes(t,i,ksd,kpr,"upper")                = v20_secondary_substitutes.up(i,ksd,kpr);
 ov_secondary_overproduction(t,i,kall,kpr,"upper")              = vm_secondary_overproduction.up(i,kall,kpr);
 ov_cost_processing(t,i,"upper")                                = vm_cost_processing.up(i);
 ov_processing_substitution_cost(t,i,"upper")                   = vm_processing_substitution_cost.up(i);
 oq20_processing(t,i,kpr,ksd,"upper")                           = q20_processing.up(i,kpr,ksd);
 oq20_processing_aggregation_nocereals(t,i,kpr,"upper")         = q20_processing_aggregation_nocereals.up(i,kpr);
 oq20_processing_aggregation_cereals(t,i,kcereals20,"upper")    = q20_processing_aggregation_cereals.up(i,kcereals20);
 oq20_processing_aggregation_cotton(t,i,"upper")                = q20_processing_aggregation_cotton.up(i);
 oq20_processing_substitution_oils(t,i,"upper")                 = q20_processing_substitution_oils.up(i);
 oq20_processing_substitution_brans(t,i,"upper")                = q20_processing_substitution_brans.up(i);
 oq20_processing_substitution_sugar(t,i,"upper")                = q20_processing_substitution_sugar.up(i);
 oq20_processing_substitution_protein(t,i,"upper")              = q20_processing_substitution_protein.up(i);
 oq20_processing_costs(t,i,"upper")                             = q20_processing_costs.up(i);
 oq20_substitution_utility_loss(t,i,"upper")                    = q20_substitution_utility_loss.up(i);
 ov_dem_processing(t,i,kall,"lower")                            = vm_dem_processing.lo(i,kall);
 ov20_dem_processing(t,i,processing_subst20,kpr,"lower")        = v20_dem_processing.lo(i,processing_subst20,kpr);
 ov20_secondary_substitutes(t,i,ksd,kpr,"lower")                = v20_secondary_substitutes.lo(i,ksd,kpr);
 ov_secondary_overproduction(t,i,kall,kpr,"lower")              = vm_secondary_overproduction.lo(i,kall,kpr);
 ov_cost_processing(t,i,"lower")                                = vm_cost_processing.lo(i);
 ov_processing_substitution_cost(t,i,"lower")                   = vm_processing_substitution_cost.lo(i);
 oq20_processing(t,i,kpr,ksd,"lower")                           = q20_processing.lo(i,kpr,ksd);
 oq20_processing_aggregation_nocereals(t,i,kpr,"lower")         = q20_processing_aggregation_nocereals.lo(i,kpr);
 oq20_processing_aggregation_cereals(t,i,kcereals20,"lower")    = q20_processing_aggregation_cereals.lo(i,kcereals20);
 oq20_processing_aggregation_cotton(t,i,"lower")                = q20_processing_aggregation_cotton.lo(i);
 oq20_processing_substitution_oils(t,i,"lower")                 = q20_processing_substitution_oils.lo(i);
 oq20_processing_substitution_brans(t,i,"lower")                = q20_processing_substitution_brans.lo(i);
 oq20_processing_substitution_sugar(t,i,"lower")                = q20_processing_substitution_sugar.lo(i);
 oq20_processing_substitution_protein(t,i,"lower")              = q20_processing_substitution_protein.lo(i);
 oq20_processing_costs(t,i,"lower")                             = q20_processing_costs.lo(i);
 oq20_substitution_utility_loss(t,i,"lower")                    = q20_substitution_utility_loss.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
