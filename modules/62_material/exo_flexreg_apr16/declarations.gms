*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalar
  s62_historical                 Switch for turning off historical material demand (1) / 1 /
;

parameters
  p62_dem_material_lh(i,kall)    Material demand in last historical timestep (mio. tDM per yr)
  p62_dem_food_lh(i)             Food demand in last historical timestep (mio. tDM per yr)
;

positive variables
  vm_dem_material(i,kall)        Demand for material usage (mio. tDM per yr)
;

equations
  q62_dem_material(i,kall)       Estimating material demand (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_material(t,i,kall,type)   Demand for material usage (mio. tDM per yr)
 oq62_dem_material(t,i,kall,type) Estimating material demand (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
