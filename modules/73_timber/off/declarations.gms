*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
p73_timber_demand_gdp_pop(t_all,i,kforestry)                                Timber demand based on lauri et al 2019 (mio. m3 per yr)
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)            End product specific timber demand (mio. m3 per yr)
pm_demand_ext(t_ext,i,kforestry)                                            Extended demand for timber beyound simulation (mio. tDM per yr)
p73_demand_ext_original(t_ext,i,kforestry)                                  Original prescribed timber demand (mio. tDM per yr)
pm_prices_woodymass(t,i,kforestry)                                          Woody biomass prices (USD per tDM)
;

positive variables
v73_prod_heaven_timber(j,kforestry)                                         Production of woody biomass from heaven (mio. tDM per yr)
vm_cost_timber(i)				                                                    Actual cost of harvesting timber from forests (mio. USD per yr)
vm_hvarea_secdforest(j,ac_sub)                                              Harvested area from secondary forest (mio. ha)
vm_hvarea_primforest(j)                                                     Harvested area from primary forest (mio. ha)
;

equations
q73_cost_timber(i)                                                          Actual cost of harvesting timber from forests (mio. USD per yr)
q73_prod_timber(j,kforestry)                                                Production of woody biomass from commercial plantations and natural vegetation (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov73_prod_heaven_timber(t,j,kforestry,type) Production of woody biomass from heaven (mio. tDM per yr)
 ov_cost_timber(t,i,type)                    Actual cost of harvesting timber from forests (mio. USD per yr)
 ov_hvarea_secdforest(t,j,ac_sub,type)       Harvested area from secondary forest (mio. ha)
 ov_hvarea_primforest(t,j,type)              Harvested area from primary forest (mio. ha)
 oq73_cost_timber(t,i,type)                  Actual cost of harvesting timber from forests (mio. USD per yr)
 oq73_prod_timber(t,j,kforestry,type)        Production of woody biomass from commercial plantations and natural vegetation (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
