*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


scalar
  s62_historical switch for turning off historical material demand / 1 /
;

parameters
  p62_dem_material_last_historical(i,kall)   material demand in last historical timestep
  p62_dem_food_last_historical(i)            food demand in last historical timestep
;

positive variables
  vm_dem_material(i,kall)         Demand for material usage (mio. tDM)
;

equations
  q62_dem_material(i,kall)     Estimating material demand
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_material(t,i,kall,type)   Demand for material usage (Mt DM)
 oq62_dem_material(t,i,kall,type) Estimating material demand
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
