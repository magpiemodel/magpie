parameters
p73_wood_products_demand_pc(t,iso,wood_products)                      Demand for wood products (mio. m3 per capita per yr)
p73_calibration_timber_demand_pc(t,iso,wood_products)                 Calibration value for wood products (mio. m3 per capita per yr)
p73_calib_lastyr_pc(iso,wood_products)                                Calibration value from previous year for wood products (mio. m3 per capita per yr)
p73_calibrated_pc(t,iso,wood_products)                                Calibrated demand for wood products (mio. m3 per capita per yr)
p73_calibrated_abs(t,iso,wood_products)                               Calibrated demand for wood products (mio. m3 per yr)
p73_calibrated_abs_glo(t)                                             Calibrated global demand for wood products (mio. m3 per yr)
;

positive variables
v73_prod_forestry(j,kforestry)                                        Production of woody biomass from commercial plantations (mio. m3 per yr)
v73_prod_natveg(j,land_natveg,ac_sub,kforestry)                       Production of woody biomass from natural vegetation (mio. m3 per yr)
vm_prod_heaven_timber(j,kforestry)                                    Production of woody biomass from heaven (mio. m3 per yr)
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
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov73_prod_forestry(t,j,kforestry,type)                  Production of woody biomass from commercial plantations (mio. m3 per yr)
 ov73_prod_natveg(t,j,land_natveg,ac_sub,kforestry,type) Production of woody biomass from natural vegetation (mio. m3 per yr)
 ov_prod_heaven_timber(t,j,kforestry,type)               Production of woody biomass from heaven (mio. m3 per yr)
 oq73_prod_timber(t,j,kforestry,type)                    Production of woody biomass from commercial plantations and natural vegetation (mio. m3 per yr)
 oq73_prod_forestry(t,j,kforestry,type)                  Production of woody biomass from commercial plantations (mio. m3 per yr)
 oq73_prod_secdforest(t,j,ac_sub,kforestry,type)         Production of woody biomass from secondary forests (mio. m3 per yr)
 oq73_hvarea_secdforest(t,j,ac_sub,kforestry,type)       Area harvested for woody biomass from secondary forests (mio. m3 per yr)
 oq73_prod_primforest(t,j,kforestry,type)                Production of woody biomass from primary forests (mio. m3 per yr)
 oq73_hvarea_primforest(t,j,kforestry,type)              Area harvested for woody biomass from primary forests (mio. m3 per yr)
 oq73_prod_other(t,j,ac_sub,type)                        Production of woody biomass from other land (mio. m3 per yr)
 oq73_hvarea_other(t,j,ac_sub,type)                      Area harvested for woody biomass from other land (mio. m3 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
