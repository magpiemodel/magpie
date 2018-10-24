*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*'
*' Not all demands are relevant for each product group therefore we distinguish
*' into diverse product groups and demand types, according to the equations
*' below. Supply balance for crops, livestock, secondary products and crop
*' residues are calculated as the summation of the corresponding demand for
*' food, feed, processing products, material, bioenergy, seed, waste and the
*' domestic balance flow. Demand for seed, waste and the domestic balance flow
*' are calculated internally within the [16_demand] module, while the other
*' relevant demand values are taken from other modules (see interface plot).

q16_supply_crops(i2,kcr) ..
                          vm_supply(i2,kcr) =e=
                          vm_dem_food(i2,kcr)
                          + sum(kap4, vm_dem_feed(i2,kap4,kcr))
                          + vm_dem_processing(i2,kcr)
                          + vm_dem_material(i2,kcr)
                          + vm_dem_bioen(i2,kcr)
                          + vm_dem_seed(i2,kcr)
                          + v16_dem_waste(i2,kcr)
                          + sum(ct, f16_domestic_balanceflow(ct,i2,kcr))
                          ;

q16_supply_livestock(i2,kap) ..
                          vm_supply(i2,kap) =e=
                          vm_dem_food(i2,kap)
                          + sum(kap4, vm_dem_feed(i2,kap4,kap))
                          + v16_dem_waste(i2,kap)
                          + vm_dem_material(i2,kap)
                          + sum(ct, f16_domestic_balanceflow(ct,i2,kap))
                          ;

q16_supply_secondary(i2,ksd) ..
                          vm_supply(i2,ksd) =e=
                          vm_dem_food(i2,ksd)
                          + sum(kap4, vm_dem_feed(i2,kap4,ksd))
                          + vm_dem_processing(i2,ksd)
                          + v16_dem_waste(i2,ksd)
                          + vm_dem_material(i2,ksd)
                          + vm_dem_bioen(i2,ksd)
                          + sum(ct, f16_domestic_balanceflow(ct,i2,ksd))
                          ;

q16_supply_residues(i2,kres)..
                          vm_supply(i2,kres) =e=
                          sum(kap4, vm_dem_feed(i2,kap4,kres))
                          + vm_dem_material(i2,kres)
                          + vm_dem_bioen(i2,kres)
                          + v16_dem_waste(i2,kres)
                          + sum(ct, f16_domestic_balanceflow(ct,i2,kres))
                          ;

*' Supply balance pasture is calculated as the regional feed demand for pasture.

q16_supply_pasture(i2) ..  vm_supply(i2,"pasture") =e=
                          sum(kap4, vm_dem_feed(i2,kap4,"pasture"));

*' Waste demand is calculated as the regional demand of all commodities
*' multiplied by the corresponding waste share and summed up with the
*' overproduction of secondary couple products.

q16_waste_demand(i2,kall) ..
                 v16_dem_waste(i2,kall) =e=
                 vm_supply(i2,kall) * sum(ct,f16_waste_shr(ct,i2,kall))
                 + sum(kpr,vm_secondary_overproduction(i2,kall,kpr));

*' Seed demand is calculated as the regional aggregated production of all
*' commodities multiplied by the corresponding seed share.

q16_seed_demand(i2,kcr) ..
                 vm_dem_seed(i2,kcr) =e=
                 vm_prod_reg(i2,kcr) * sum(ct,f16_seed_shr(ct,i2,kcr));
