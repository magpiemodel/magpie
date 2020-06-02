*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
p73_wood_products_demand_reg(t,i,kforestry)                                 Regional wood products demand (mio. m3 per yr)
p73_wood_products_demand_GLO(t,kforestry)                                   Global wood products demand (mio. m3 per yr)
p73_income_elasticity(total_wood_products)                                  GDP Elasticity (1)
p73_timber_demand_gdp_pop(t_all,i,kforestry)                                Timber demand based on lauri et al 2019 (mio. m3 per yr)
i73_gdp_ppp_pc_iso(t_all,iso,gdp_scen09)                                    GDPpc at iso level (mio. USD per capita)
p73_forestry_demand(t_all,iso,kforestry)                                    Aggregated timber demand demand (mio. m3 per yr)
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)            End product specific timber demand (mio. m3 per yr)
pm_demand_ext(t_ext,i,kforestry)                                            Extended demand for timber beyound simulation (mio. tDM per yr)
p73_glo_timber_demand(t_all,kforestry)                                      Global timber demand (mio. m3 per yr)
p73_volumetric_conversion(kforestry)                                        Volumetric conversion factor for volume to mass (tDM per m3)
p73_demand_ext_original(t_ext,i,kforestry)                                  Original prescribed timber demand (mio. tDM per yr)
pm_prices_woodymass(t,i,kforestry)                                          Woody biomass prices (USD per tDM)
p73_criterion	                                                              Criteria calculating timber demand adjustment (mio. tDM per yr)
p73_timder_adjustment_ratio(t,i,kforestry)                                  Ratio between adjusted and prescribed timber demand (1)
p73_price_ratio(t,i,kforestry)                                              Price ratio from current step to base year (1)
p73_price_ratio_before(t,i,kforestry)                                       Price ratio from current step to base year before adjustment (1)
p73_demand_adjustor(t,i,kforestry)                                          Timber demand adjustor (1)
;

positive variables
v73_cost_hvarea(i)                                                          Cost of harvesting timber from forests (mio. USD per yr)
v73_prod_forestry(j,ac_sub,kforestry)                                       Production of woody biomass from commercial plantations (mio. tDM per yr)
v73_prod_natveg(j,land_natveg,ac_sub,kforestry)                             Production of woody biomass from natural vegetation (mio. tDM per yr)
v73_prod_heaven_timber(j,kforestry)                                         Production of woody biomass from heaven (mio. tDM per yr)
vm_cost_timber(i)				                                                    Actual cost of harvesting timber from forests (mio. USD per yr)
vm_hvarea_secdforest(j,ac_sub)                                              Harvested area from secondary forest (mio. ha)
v73_hvarea_other(j,ac_sub)                                                  Harvested area from other land (mio. ha)
vm_hvarea_primforest(j)                                                     Harvested area from primary forest (mio. ha)
v73_hvarea_forestry(j,ac_sub)                                               Harvested area from timber plantations(mio. ha)
;

equations
q73_cost_timber(i)												                                  Actual cost of harvesting timber from forests (mio. USD per yr)
q73_cost_hvarea(i)												                                  Cost of harvesting timber from forests (mio. USD per yr)
q73_prod_timber(j,kforestry)                                                Production of woody biomass from commercial plantations and natural vegetation (mio. tDM per yr)
q73_prod_forestry(j,ac_sub)                                                 Production of woody biomass from commercial plantations (mio. tDM per yr)
q73_hvarea_forestry(j,ac_sub)                                               Area harvested from commercial plantations (mio. ha per yr)
q73_prod_secdforest(j,ac_sub)                                               Production of woody biomass from secondary forests (mio. tDM per yr)
q73_hvarea_secdforest(j,ac_sub)                                             Area harvested for woody biomass from secondary forests (mio. tDM per yr)
q73_prod_primforest(j)                                                      Production of woody biomass from primary forests (mio. tDM per yr)
q73_hvarea_primforest(j)                                                    Area harvested for woody biomass from primary forests (mio. tDM per yr)
q73_prod_other(j,ac_sub)                                                    Production of woody biomass from other land (mio. tDM per yr)
q73_hvarea_other(j,ac_sub)                                                  Area harvested for woody biomass from other land (mio. tDM per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov73_cost_hvarea(t,i,type)                              Cost of harvesting timber from forests (mio. USD per yr)
 ov73_prod_forestry(t,j,ac_sub,kforestry,type)           Production of woody biomass from commercial plantations (mio. tDM per yr)
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,type) Production of woody biomass from natural vegetation (mio. tDM per yr)
 ov73_prod_heaven_timber(t,j,kforestry,type)             Production of woody biomass from heaven (mio. tDM per yr)
 ov_cost_timber(t,i,type)                                Actual cost of harvesting timber from forests (mio. USD per yr)
 ov_hvarea_secdforest(t,j,ac_sub,type)                   Harvested area from secondary forest (mio. ha per yr)
 ov73_hvarea_other(t,j,ac_sub,type)                      Harvested area from other land (mio. ha per yr)
 ov_hvarea_primforest(t,j,type)                          Harvested area from primary forest (mio. ha per yr)
 ov73_hvarea_forestry(t,j,ac_sub,type)                   Harvested area from timber plantations(mio. ha per yr)
 oq73_cost_timber(t,i,type)                              Actual cost of harvesting timber from forests (mio. USD per yr)
 oq73_cost_hvarea(t,i,type)                              Cost of harvesting timber from forests (mio. USD per yr)
 oq73_prod_timber(t,j,kforestry,type)                    Production of woody biomass from commercial plantations and natural vegetation (mio. tDM per yr)
 oq73_prod_forestry(t,j,ac_sub,type)                     Production of woody biomass from commercial plantations (mio. tDM per yr)
 oq73_hvarea_forestry(t,j,ac_sub,type)                   Area harvested from commercial plantations (mio. ha per yr)
 oq73_prod_secdforest(t,j,ac_sub,type)                   Production of woody biomass from secondary forests (mio. tDM per yr)
 oq73_hvarea_secdforest(t,j,ac_sub,type)                 Area harvested for woody biomass from secondary forests (mio. tDM per yr)
 oq73_prod_primforest(t,j,type)                          Production of woody biomass from primary forests (mio. tDM per yr)
 oq73_hvarea_primforest(t,j,type)                        Area harvested for woody biomass from primary forests (mio. tDM per yr)
 oq73_prod_other(t,j,ac_sub,type)                        Production of woody biomass from other land (mio. tDM per yr)
 oq73_hvarea_other(t,j,ac_sub,type)                      Area harvested for woody biomass from other land (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
