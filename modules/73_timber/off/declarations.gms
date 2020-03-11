*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
pm_demand_ext(t_ext,i,kforestry)                                            Extended demand for timber beyound simulation (mio. m3)
;

positive variables
vm_prod_heaven_timber(j,kforestry)                                    Production of woody biomass from heaven (mio. m3 per yr)
vm_cost_timber(i)				blub
  vm_hvarea_secdforest(j,ac_sub)      Harvested area of secondary forest (mio. ha)
  vm_hvarea_other(j,ac_sub)           Harvested area of other land (mio. ha)
  vm_hvarea_primforest(j)             Harvested area of primary forest (mio. ha)
 vm_hvarea_forestry(j,ac_sub)             Area harvested for timber production (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_prod_heaven_timber(t,j,kforestry,type) Production of woody biomass from heaven (mio. m3 per yr)
 ov_cost_timber(t,i,type)                  blub
 ov_hvarea_secdforest(t,j,ac_sub,type)     Harvested area of secondary forest (mio. ha)
 ov_hvarea_other(t,j,ac_sub,type)          Harvested area of other land (mio. ha)
 ov_hvarea_primforest(t,j,type)            Harvested area of primary forest (mio. ha)
 ov_hvarea_forestry(t,j,ac_sub,type)       Area harvested for timber production (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
