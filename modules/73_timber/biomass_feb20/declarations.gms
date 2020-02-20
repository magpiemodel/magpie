*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
p73_wood_products_demand_pc(t,iso,total_wood_products)                      Demand for wood products (mio. m3 per capita per yr)
p73_calibration_timber_demand_pc(t,iso,total_wood_products)                 Calibration value for wood products (mio. m3 per capita per yr)
p73_calib_lastyr_pc(iso,total_wood_products)                                Calibration value from previous year for wood products (mio. m3 per capita per yr)
p73_calibrated_pc(t,iso,total_wood_products)                                Calibrated demand for wood products (mio. m3 per capita per yr)
p73_calibrated_abs(t,iso,total_wood_products)                               Calibrated demand for wood products (mio. m3 per yr)
p73_calibrated_abs_glo(t)                                                   Calibrated global demand for wood products (mio. m3 per yr)
p73_wood_products_demand_reg(t,i,kforestry)                                 Regional wood products demand (mio. m3 per yr)
p73_wood_products_demand_GLO(t,kforestry)                                   Global wood products demand (mio. m3 per yr)
p73_elasticity(kforestry)                                                   GDP Elasticity (1)
pm_iiasa_timber(t_all,i,kforestry)                                            Timber demand based on lauri et al 2019 (mio. m3 per yr)
pm_iiasa_GLO(t_all,kforestry)                                               Global timber demand (mio. m3 per yr)
i73_gdp_ppp_pc_iso(t_all,iso,gdp_scen09)                                    GDPpc at iso level (mio. USD per capita)
pm_forestry_demand(t_all,iso,kforestry)                                     Final forestry demand (mio. m3 per yr)
;

positive variables
v73_prod_forestry(j,kforestry)                                        Production of woody biomass from commercial plantations (mio. m3 per yr)
v73_prod_natveg(j,land_natveg,ac_sub,kforestry)                       Production of woody biomass from natural vegetation (mio. m3 per yr)
vm_prod_heaven_timber(j,kforestry)                                    Production of woody biomass from heaven (mio. m3 per yr)
v73_timber_demand(i,kforestry)                                       Timber demand (mio. m3 per yr)
;

equations
q73_prod_timber(j,kforestry)                                          Production of woody biomass from commercial plantations and natural vegetation (mio. m3 per yr)
q73_prod_forestry(j,kforestry)                                        Production of woody biomass from commercial plantations (mio. m3 per yr)
q73_prod_secdforest(j,ac_sub,kforestry)                               Production of woody biomass from secondary forests (mio. m3 per yr)
q73_hvarea_secdforest(j,ac_sub,kforestry)                             Area harvested for woody biomass from secondary forests (mio. m3 per yr)
q73_prod_primforest(j,kforestry)                                      Production of woody biomass from primary forests (mio. m3 per yr)
q73_hvarea_primforest(j,kforestry)                                    Area harvested for woody biomass from primary forests (mio. m3 per yr)
q73_prod_other(j,ac_sub)                                              Production of woody biomass from other land (mio. m3 per yr)
q73_hvarea_other(j,ac_sub)                                            Area harvested for woody biomass from other land (mio. m3 per yr)
q73_timber_demand(i,kforestry)                                        Timber demand (mio. m3 per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov73_prod_forestry(t,j,kforestry,type)                  Production of woody biomass from commercial plantations (mio. m3 per yr)
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,type) Production of woody biomass from natural vegetation (mio. m3 per yr)
 ov_prod_heaven_timber(t,j,kforestry,type)               Production of woody biomass from heaven (mio. m3 per yr)
 ov73_timber_demand(t,i,kforestry,type)                  Timber demand (mio. m3 per yr)
 oq73_prod_timber(t,j,kforestry,type)                    Production of woody biomass from commercial plantations and natural vegetation (mio. m3 per yr)
 oq73_prod_forestry(t,j,kforestry,type)                  Production of woody biomass from commercial plantations (mio. m3 per yr)
 oq73_prod_secdforest(t,j,ac_sub,kforestry,type)         Production of woody biomass from secondary forests (mio. m3 per yr)
 oq73_hvarea_secdforest(t,j,ac_sub,kforestry,type)       Area harvested for woody biomass from secondary forests (mio. m3 per yr)
 oq73_prod_primforest(t,j,kforestry,type)                Production of woody biomass from primary forests (mio. m3 per yr)
 oq73_hvarea_primforest(t,j,kforestry,type)              Area harvested for woody biomass from primary forests (mio. m3 per yr)
 oq73_prod_other(t,j,ac_sub,type)                        Production of woody biomass from other land (mio. m3 per yr)
 oq73_hvarea_other(t,j,ac_sub,type)                      Area harvested for woody biomass from other land (mio. m3 per yr)
 oq73_timber_demand(t,i,kforestry,type)                  Timber demand (mio. m3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
