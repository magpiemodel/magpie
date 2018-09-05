*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*** calculate food demand growth for material demand module
*' The material demand is set greater than or equal to the historical material
*' demand when the switch for calculating historical material demand is turned on
*' (i.e.,`s62_historical` = 1). When `s62_historical` is switched to 0, demand
*' for material usage is calculated as the product of material demand in last
*' historical timestep with food demand weighted by the food demand in last
*' historical timestep.

 q62_dem_material(i2,kall) ..
                      vm_dem_material(i2,kall)
                      =e=
                      sum(ct,f62_dem_material(ct,i2,kall))*s62_historical
                      +
                      (p62_dem_material_lh(i2,kall)*
                           sum(kfo, vm_dem_food.l(i2,kfo))
                           /(p62_dem_food_lh(i2))
                      )*(1-s62_historical)
                      ;

*' Results are stored in the interface `vm_dem_material`. This interface is then
*' used in demand([16_demand]) module as a part of global supply-demand balance
*' for crop, livestock, secondary products and residues.
