*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*### calculate food demand growth for material demand module
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