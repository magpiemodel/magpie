*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


scalar
  s62_historical                              switch for turning off historical material demand (1) / 1 /
;

parameters
  p62_dem_material_last_historical(i,kall)    Material demand in last historical timestep (mio. tDM)
  p62_dem_food_last_historical(i)             Food demand in last historical timestep (mio. tDM)
;

positive variables
  vm_dem_material(i,kall)                     Demand for material usage (mio. tDM)
;

equations
  q62_dem_material(i,kall)                    Estimating material demand (mio. tDM)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_material(t,i,kall,type)               Demand for material usage (mio. tDM)
 oq62_dem_material(t,i,kall,type)             Estimating material demand (mio. tDM)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
