*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_supply(t,i,kall,"marginal")                 = vm_supply.m(i,kall);
 ov16_dem_waste(t,i,kall,"marginal")            = v16_dem_waste.m(i,kall);
 ov_dem_seed(t,i,kall,"marginal")               = vm_dem_seed.m(i,kall);
 oq16_supply_crops(t,i,kcr,"marginal")          = q16_supply_crops.m(i,kcr);
 oq16_supply_livestock(t,i,kap,"marginal")      = q16_supply_livestock.m(i,kap);
 oq16_supply_secondary(t,i,ksd,"marginal")      = q16_supply_secondary.m(i,ksd);
 oq16_supply_residues(t,i,kres,"marginal")      = q16_supply_residues.m(i,kres);
 oq16_supply_pasture(t,i,"marginal")            = q16_supply_pasture.m(i);
 oq16_waste_demand(t,i,kall,"marginal")         = q16_waste_demand.m(i,kall);
 oq16_seed_demand(t,i,kcr,"marginal")           = q16_seed_demand.m(i,kcr);
 oq16_supply_forestry(t,i,kforestry,"marginal") = q16_supply_forestry.m(i,kforestry);
 ov_supply(t,i,kall,"level")                    = vm_supply.l(i,kall);
 ov16_dem_waste(t,i,kall,"level")               = v16_dem_waste.l(i,kall);
 ov_dem_seed(t,i,kall,"level")                  = vm_dem_seed.l(i,kall);
 oq16_supply_crops(t,i,kcr,"level")             = q16_supply_crops.l(i,kcr);
 oq16_supply_livestock(t,i,kap,"level")         = q16_supply_livestock.l(i,kap);
 oq16_supply_secondary(t,i,ksd,"level")         = q16_supply_secondary.l(i,ksd);
 oq16_supply_residues(t,i,kres,"level")         = q16_supply_residues.l(i,kres);
 oq16_supply_pasture(t,i,"level")               = q16_supply_pasture.l(i);
 oq16_waste_demand(t,i,kall,"level")            = q16_waste_demand.l(i,kall);
 oq16_seed_demand(t,i,kcr,"level")              = q16_seed_demand.l(i,kcr);
 oq16_supply_forestry(t,i,kforestry,"level")    = q16_supply_forestry.l(i,kforestry);
 ov_supply(t,i,kall,"upper")                    = vm_supply.up(i,kall);
 ov16_dem_waste(t,i,kall,"upper")               = v16_dem_waste.up(i,kall);
 ov_dem_seed(t,i,kall,"upper")                  = vm_dem_seed.up(i,kall);
 oq16_supply_crops(t,i,kcr,"upper")             = q16_supply_crops.up(i,kcr);
 oq16_supply_livestock(t,i,kap,"upper")         = q16_supply_livestock.up(i,kap);
 oq16_supply_secondary(t,i,ksd,"upper")         = q16_supply_secondary.up(i,ksd);
 oq16_supply_residues(t,i,kres,"upper")         = q16_supply_residues.up(i,kres);
 oq16_supply_pasture(t,i,"upper")               = q16_supply_pasture.up(i);
 oq16_waste_demand(t,i,kall,"upper")            = q16_waste_demand.up(i,kall);
 oq16_seed_demand(t,i,kcr,"upper")              = q16_seed_demand.up(i,kcr);
 oq16_supply_forestry(t,i,kforestry,"upper")    = q16_supply_forestry.up(i,kforestry);
 ov_supply(t,i,kall,"lower")                    = vm_supply.lo(i,kall);
 ov16_dem_waste(t,i,kall,"lower")               = v16_dem_waste.lo(i,kall);
 ov_dem_seed(t,i,kall,"lower")                  = vm_dem_seed.lo(i,kall);
 oq16_supply_crops(t,i,kcr,"lower")             = q16_supply_crops.lo(i,kcr);
 oq16_supply_livestock(t,i,kap,"lower")         = q16_supply_livestock.lo(i,kap);
 oq16_supply_secondary(t,i,ksd,"lower")         = q16_supply_secondary.lo(i,ksd);
 oq16_supply_residues(t,i,kres,"lower")         = q16_supply_residues.lo(i,kres);
 oq16_supply_pasture(t,i,"lower")               = q16_supply_pasture.lo(i);
 oq16_waste_demand(t,i,kall,"lower")            = q16_waste_demand.lo(i,kall);
 oq16_seed_demand(t,i,kcr,"lower")              = q16_seed_demand.lo(i,kcr);
 oq16_supply_forestry(t,i,kforestry,"lower")    = q16_supply_forestry.lo(i,kforestry);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
