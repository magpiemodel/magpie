*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_carbon_density_secdforest_ac(t_all,j,ac,ag_pools)            Vegetation secondary forest carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_secdforest_ac_uncalib(t_all,j,ac,ag_pools)   Vegetation secondary forest carbon density uncalibrated (tC per ha)
 pm_carbon_density_other_ac(t_all,j,ac,ag_pools)                Vegetation other land carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_plantation_ac(t_all,j,ac,ag_pools)            Vegetation plantation carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_plantation_ac_uncalib(t_all,j,ac,ag_pools)   Vegetation plantation carbon density uncalibrated (tC per ha)
 pc52_carbon_density_start(t_all,j,ag_pools)  Vegetation carbon density for new land in other land pool (tC per ha)
 i52_land_carbon_sink(t_all,i)        Land carbon sink adjustment factors from Grassi et al 2021 (GtCO2 per year)
 i52_k_low(i)                         Lower bound for bisection of growth rate k (1)
 i52_k_high(i)                        Upper bound for bisection of growth rate k (1)
 i52_k_calib_secdf(i)                 Calibrated growth rate k for secdforest (1)
 i52_k_calib_plant(i)                 Calibrated growth rate k for plantations (1)
 i52_gs_current(i)                    Current area-weighted growing stock for natural forest calibration (m3 per ha)
 i52_m_avg_natveg(i)                  Region-average shape parameter m for natveg (1)
 i52_m_avg_plant(i)                   Region-average shape parameter m for plantations (1)
 im_vol_conv(i)                       Regional basic wood density (tDM per m3)
 i52_bef_avg(i)                       Regional average biomass expansion factor (1)
 i52_gs_current_plant(i)              Current area-weighted growing stock for plantations (m3 per ha)

;

equations
  q52_emis_co2_actual(i,emis_oneoff)                  Calculation of annual CO2 emissions (Tg per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq52_emis_co2_actual(t,i,emis_oneoff,type) Calculation of annual CO2 emissions (Tg per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
