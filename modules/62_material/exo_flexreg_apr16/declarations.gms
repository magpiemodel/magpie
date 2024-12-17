*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalar
  s62_historical                 Switch for turning off historical material demand (1) / 1 /
  s62_growth_rate_bioplastic     Logistic growth rate of bioplastic demand (1);
;

parameters
  p62_dem_material_lastcalibyear(i,kall)            Material demand in last historical timestep (mio. tDM per yr)
  p62_dem_food_lastcalibyear(i)                     Food demand in last historical timestep (mio. tDM per yr)
  p62_scaling_factor(i)                             Scaling factor for material demand (1)
  p62_dem_bioplastic(t,i)                           Demand for bioplastic (mio. t per yr)
  p62_bioplastic_substrate(t,i,kall)                Regional biomass needed as substrate for bioplastic production (mio. tDM per yr)
  p62_bioplastic_substrate_lastcalibyear(i,kall)    Bioplastic substrate in last historical timestep (mio. tDM per yr) 
  p62_bioplastic_substrate_double_counted(t,i,kall) Bioplastic substrate counted both in general material demand and demand for bioplastic (mio. tDM per yr)
;

positive variables
  vm_dem_material(i,kall)        Demand for material usage (mio. tDM per yr)
;

equations
  q62_dem_material(i,kall_excl_kforestry) Estimating material demand (mio. tDM per yr)
  q62_dem_material_forestry(i,kforestry)  Demand for forestry products (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_material(t,i,kall,type)                  Demand for material usage (mio. tDM per yr)
 oq62_dem_material(t,i,kall_excl_kforestry,type) Estimating material demand (mio. tDM per yr)
 oq62_dem_material_forestry(t,i,kforestry,type)  Demand for forestry products (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
