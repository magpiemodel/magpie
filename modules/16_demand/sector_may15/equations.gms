*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



q16_supply_crops(i2,kcr) ..
                          vm_supply(i2,kcr)
                          =g=
                          vm_dem_food(i2,kcr)
                          + sum(kap2, vm_dem_feed(i2,kap2,kcr))
                          + vm_dem_processing(i2,kcr)
                          + sum(ct, pm_dem_material(ct,i2,kcr))
                          + vm_dem_bioen(i2,kcr)
                          + vm_dem_seed(i2,kcr)
                          + v16_dem_waste(i2,kcr)
                          + sum(ct, f16_domestic_balanceflow(ct,i2,kcr))
                          ;

q16_supply_livestock(i2,kap) ..
                          vm_supply(i2,kap)
                          =g=
                          vm_dem_food(i2,kap)
                          + sum(kap2, vm_dem_feed(i2,kap2,kap))
                          + v16_dem_waste(i2,kap)
                          + sum(ct, pm_dem_material(ct,i2,kap))
                          + sum(ct, f16_domestic_balanceflow(ct,i2,kap))
                          ;


q16_supply_secondary(i2,ksd) ..
                          vm_supply(i2,ksd)
                          =g=
                          vm_dem_food(i2,ksd)
                          + sum(kap2, vm_dem_feed(i2,kap2,ksd))
                          + vm_dem_processing(i2,ksd)
                          + v16_dem_waste(i2,ksd)
                          + sum(ct, pm_dem_material(ct,i2,ksd))
                          + vm_dem_bioen(i2,ksd)
                          + sum(ct, f16_domestic_balanceflow(ct,i2,ksd))
                          ;

q16_supply_residues(i2,kres)..
                          vm_supply(i2,kres)
                          =g=
                          sum(kap2, vm_dem_feed(i2,kap2,kres))
                          + sum(ct, pm_dem_material(ct,i2,kres))
                          + vm_dem_bioen(i2,kres)
                          + v16_dem_waste(i2,kres)
                          ;

q16_supply_pasture(i2) ..  vm_supply(i2,"pasture")
                          =e=
                          sum(kap2, vm_dem_feed(i2,kap2,"pasture"))
                          ;

q16_waste_demand(i2,kall) ..
                 v16_dem_waste(i2,kall)
                 =e=
                 vm_supply(i2,kall) * sum(ct,f16_waste_shr(ct,i2,kall));

q16_seed_demand(i2,kcr) ..
                 vm_dem_seed(i2,kcr)
                 =e=
                 vm_prod_reg(i2,kcr) * sum(ct,f16_seed_shr(ct,i2,kcr));