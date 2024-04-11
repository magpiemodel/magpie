*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



positive variables
vm_supply(i,kall)                 Regional demand (mio. tDM per yr)
v16_dem_waste(i,kall)             Demand for waste (mio. tDM per yr)
vm_dem_seed(i,kall)               Demand for seed (mio. tDM per yr)
;

equations
q16_supply_crops(i,kcr)          Supply balance of crops (mio. tDM per yr)
q16_supply_livestock(i,kap)      Supply balance of livestock (mio. tDM per yr)
q16_supply_secondary(i,ksd)      Supply balance of secondary products (mio. tDM per yr)
q16_supply_residues(i,kres)      Supply balance of crop residues (mio. tDM per yr)
q16_supply_pasture(i)            Supply balance of pasture (mio. tDM per yr)
q16_waste_demand(i,kall)         Waste generation (mio. tDM per yr)
q16_seed_demand(i,kcr)           Seed demand (mio. tDM per yr)
q16_supply_forestry(i,kforestry)          Forestry demand (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_supply(t,i,kall,type)                 Regional demand (mio. tDM per yr)
 ov16_dem_waste(t,i,kall,type)            Demand for waste (mio. tDM per yr)
 ov_dem_seed(t,i,kall,type)               Demand for seed (mio. tDM per yr)
 oq16_supply_crops(t,i,kcr,type)          Supply balance of crops (mio. tDM per yr)
 oq16_supply_livestock(t,i,kap,type)      Supply balance of livestock (mio. tDM per yr)
 oq16_supply_secondary(t,i,ksd,type)      Supply balance of secondary products (mio. tDM per yr)
 oq16_supply_residues(t,i,kres,type)      Supply balance of crop residues (mio. tDM per yr)
 oq16_supply_pasture(t,i,type)            Supply balance of pasture (mio. tDM per yr)
 oq16_waste_demand(t,i,kall,type)         Waste generation (mio. tDM per yr)
 oq16_seed_demand(t,i,kcr,type)           Seed demand (mio. tDM per yr)
 oq16_supply_forestry(t,i,kforestry,type) Forestry demand (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
