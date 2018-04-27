*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



positive variables
vm_supply(i,kall)                 Regional demand (mio. tDM)
v16_dem_waste(i,kall)             Demand for waste (mio. tDM)
vm_dem_seed(i,kall)               Demand for seed (mio. tDM)
;

equations
q16_supply_crops(i,kcr)          Supply balance crops (mio. tDM)
q16_supply_livestock(i,kap)      Supply balance livestock (mio. tDM)
q16_supply_secondary(i,ksd)      Supply balance secondary products (mio. tDM)
q16_supply_residues(i,kres)      Supply balance crop residues (mio. tDM)
q16_supply_pasture(i)            Supply balance pasture (mio. tDM)
q16_waste_demand(i,kall)         Waste Demand (mio. tDM)
q16_seed_demand(i,kcr)           Seed Demand (mio. tDM)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_supply(t,i,kall,type)            Regional demand (mio. tDM)
 ov16_dem_waste(t,i,kall,type)       Demand for waste (mio. tDM)
 ov_dem_seed(t,i,kall,type)          Demand for seed (mio. tDM)
 oq16_supply_crops(t,i,kcr,type)     Supply balance crops (mio. tDM)
 oq16_supply_livestock(t,i,kap,type) Supply balance livestock (mio. tDM)
 oq16_supply_secondary(t,i,ksd,type) Supply balance secondary products (mio. tDM)
 oq16_supply_residues(t,i,kres,type) Supply balance crop residues (mio. tDM)
 oq16_supply_pasture(t,i,type)       Supply balance pasture (mio. tDM)
 oq16_waste_demand(t,i,kall,type)    Waste Demand (mio. tDM)
 oq16_seed_demand(t,i,kcr,type)      Seed Demand (mio. tDM)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
