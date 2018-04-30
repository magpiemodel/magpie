*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*** calculate food demand growth for material demand module
 q62_dem_material(i2,kall) ..
                      vm_dem_material(i2,kall)
                      =g=
                      sum(ct,f62_dem_material(ct,i2,kall))*s62_historical
                      +
                      (p62_dem_material_last_historical(i2,kall)*
                           sum(kfo, vm_dem_food.l(i2,kfo))
                           /(p62_dem_food_last_historical(i2))
                      )*(1-s62_historical)
                      ;

*' The material demand is set greater than or equal to the historical material demand
*' when the switch for calculating historical material demand is on (i.e.,s62_historical = 1)
*' When s62_historical is switched to 0, Demand for material usage is calculated as
*' the product of material demand in last historical timestep with food demand weighted by
*' the food demand in last historical timestep. The results are stored in the interface
*' `vm_dem_material`. This interface is then used in the demand([16_demand]) module as a part of
*' global supply-demand balance for crop (`q16_supply_crops`), livestock (`q16_supply_livestock`),
*' secondary products (`q16_supply_secondary`) and residues (`q16_supply_residues`)
