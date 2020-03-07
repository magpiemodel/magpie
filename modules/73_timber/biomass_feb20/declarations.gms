*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
p73_wood_products_demand_reg(t,i,kforestry)                                 Regional wood products demand (mio. m3 per yr)
p73_wood_products_demand_GLO(t,kforestry)                                   Global wood products demand (mio. m3 per yr)
p73_income_elasticity(total_wood_products)                                  GDP Elasticity (1)
p73_timber_demand_gdp_pop(t_all,i,kforestry)                                            Timber demand based on lauri et al 2019 (mio. m3 per yr)
i73_gdp_ppp_pc_iso(t_all,iso,gdp_scen09)                                    GDPpc at iso level (mio. USD per capita)
p73_forestry_demand(t_all,iso,kforestry)                                     Final forestry demand (mio. m3 per yr)
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)                   Final forestry demand (mio. m3 per yr)
pm_demand_ext(t_ext,i,kforestry)                                            Extended demand for timber beyound simulation (mio. m3)
p73_glo_timber_demand(t_all,kforestry)                                      Global timber demand (mio. m3 per yr)
p73_volumetric_conversion(kforestry)  blub
;

positive variables
v73_cost_hvarea(i)
v73_prod_forestry(j,ac_sub,kforestry)                                        Production of woody biomass from commercial plantations (mio. m3 per yr)
v73_prod_natveg(j,land_natveg,ac_sub,kforestry)                       Production of woody biomass from natural vegetation (mio. m3 per yr)
vm_prod_heaven_timber(j,kforestry)                                    Production of woody biomass from heaven (mio. m3 per yr)
v73_prod_ton(j,kforestry)                                        Production of woody biomass from commercial plantations (mio. ton per yr)
vm_cost_timber(i)				blub
  vm_hvarea_secdforest(j,ac_sub)      Harvested area of secondary forest (mio. ha)
  vm_hvarea_other(j,ac_sub)           Harvested area of other land (mio. ha)
  vm_hvarea_primforest(j)             Harvested area of primary forest (mio. ha)
 vm_hvarea_forestry(j,ac_sub)             Area harvested for timber production (mio. ha)
;

equations
q73_cost_timber(i)												blub
q73_cost_hvarea(i)												blub
q73_prod_timber(j,kforestry)                                          Production of woody biomass from commercial plantations and natural vegetation (mio. m3 per yr)
q73_prod_timber_ton(j,kforestry)									blubs
q73_prod_forestry(j,ac_sub)                                        Production of woody biomass from commercial plantations (mio. m3 per yr)
q73_hvarea_forestry(j,ac_sub)
q73_prod_secdforest(j,ac_sub)                               Production of woody biomass from secondary forests (mio. m3 per yr)
q73_hvarea_secdforest(j,ac_sub)                             Area harvested for woody biomass from secondary forests (mio. m3 per yr)
q73_prod_primforest(j)                                      Production of woody biomass from primary forests (mio. m3 per yr)
q73_hvarea_primforest(j)                                    Area harvested for woody biomass from primary forests (mio. m3 per yr)
q73_prod_other(j,ac_sub)                                              Production of woody biomass from other land (mio. m3 per yr)
q73_hvarea_other(j,ac_sub)                                            Area harvested for woody biomass from other land (mio. m3 per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov73_cost_hvarea(t,i,type)                              
 ov73_prod_forestry(t,j,ac_sub,kforestry,type)           Production of woody biomass from commercial plantations (mio. m3 per yr)
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,type) Production of woody biomass from natural vegetation (mio. m3 per yr)
 ov_prod_heaven_timber(t,j,kforestry,type)               Production of woody biomass from heaven (mio. m3 per yr)
 ov73_prod_ton(t,j,kforestry,type)                       Production of woody biomass from commercial plantations (mio. ton per yr)
 ov_cost_timber(t,i,type)                                blub
 ov_hvarea_secdforest(t,j,ac_sub,type)                   Harvested area of secondary forest (mio. ha)
 ov_hvarea_other(t,j,ac_sub,type)                        Harvested area of other land (mio. ha)
 ov_hvarea_primforest(t,j,type)                          Harvested area of primary forest (mio. ha)
 ov_hvarea_forestry(t,j,ac_sub,type)                     Area harvested for timber production (mio. ha)
 oq73_cost_timber(t,i,type)                              blub
 oq73_cost_hvarea(t,i,type)                              blub
 oq73_prod_timber(t,j,kforestry,type)                    Production of woody biomass from commercial plantations and natural vegetation (mio. m3 per yr)
 oq73_prod_timber_ton(t,j,kforestry,type)                blubs
 oq73_prod_forestry(t,j,ac_sub,type)                     Production of woody biomass from commercial plantations (mio. m3 per yr)
 oq73_hvarea_forestry(t,j,ac_sub,type)                   
 oq73_prod_secdforest(t,j,ac_sub,type)                   Production of woody biomass from secondary forests (mio. m3 per yr)
 oq73_hvarea_secdforest(t,j,ac_sub,type)                 Area harvested for woody biomass from secondary forests (mio. m3 per yr)
 oq73_prod_primforest(t,j,type)                          Production of woody biomass from primary forests (mio. m3 per yr)
 oq73_hvarea_primforest(t,j,type)                        Area harvested for woody biomass from primary forests (mio. m3 per yr)
 oq73_prod_other(t,j,ac_sub,type)                        Production of woody biomass from other land (mio. m3 per yr)
 oq73_hvarea_other(t,j,ac_sub,type)                      Area harvested for woody biomass from other land (mio. m3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
