*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_carbon_density_secdforest_ac(t_all,j,ac,ag_pools)   Above ground secondary forest carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_other_ac(t_all,j,ac,ag_pools)        Above ground other land carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_plantation_ac(t_all,j,ac,ag_pools)     Above ground plantation carbon density for age classes and carbon pools (tC per ha)
 pc52_carbon_density_start(t_all,j,ag_pools)  Above ground carbon density for new land in other land pool (tC per ha)
 i52_land_carbon_sink(t_all,i)        Land carbon sink adjustment factors from Grassi et al 2021 (GtCO2 per year)
;

equations
  q52_emis_co2_actual(i,emis_oneoff)                  Calculation of annual CO2 emissions (Tg per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq52_emis_co2_actual(t,i,emis_oneoff,type) Calculation of annual CO2 emissions (Tg per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
