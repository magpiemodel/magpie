*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Estimation of material demand depends on the value set by switch
*' `s62_historical`. When it is set to 1, the material demand is estimated
*' purely based on the historical material demand as reported by FAO.
*' When `s62_historical` is switched to 0, the Material demand is calculated
*' as the scaled version of material demand in last historical timestep
*' depending on a scaling factor. This scaling factor is calculated as the
*' ratio beween the food demand from last timestep and the food demand from
*' the last historical time step.

 q62_dem_material(i2,kall) ..
                      vm_dem_material(i2,kall)
                      =e=
                      sum(ct,f62_dem_material(ct,i2,kall))*s62_historical
                      +
                      (p62_dem_material_lh(i2,kall)*
                           sum(kfo, vm_dem_food.l(i2,kfo))
                           /(p62_dem_food_lh(i2)))
                      *(1-s62_historical)
                      ;

*' Results are stored in the interface `vm_dem_material` and this interface
*' is then used in demand([16_demand]) module as a part of global supply-demand
*' balance for crop, livestock, secondary products and residues.
