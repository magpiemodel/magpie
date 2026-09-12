*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_carbon_density_secdforest_ac(t_all,j,ac,ag_pools)            Vegetation secondary forest carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_other_planted_ac(t_all,j,ac,ag_pools)        Vegetation other-planted forest carbon density - natveg-derived curve read from f52_growth_par other_planted (tC per ha)
 pm_carbon_density_other_ac(t_all,j,ac,ag_pools)                Vegetation other land carbon density for age classes and carbon pools (tC per ha)
 pm_carbon_density_plantation_ac(t_all,j,ac,ag_pools)            Vegetation plantation carbon density for age classes and carbon pools (tC per ha)
 pc52_carbon_density_start(t_all,j,ag_pools)  Vegetation carbon density for new land in other land pool (tC per ha)
 i52_land_carbon_sink(t_all,i)        Land carbon sink adjustment factors from Grassi et al 2021 (GtCO2 per year)
 im_vol_conv(i)                       Regional basic wood density (tDM per m3)
 i52_bef_avg(i)                       Regional average biomass expansion factor (1)
 i52_gs_curve_nrf(i)                  Growing stock the carbon curve implies for natural forest (age-area-weighted) - reference the FRA wood multiplier calibrates against (m3 per ha)
 i52_gs_curve_pla(i)                  Growing stock the carbon curve implies for plantations (at the rotation age) - reference the FRA wood multiplier calibrates against (m3 per ha)
 pm_lambda_nrf(i)                     Wood-only FRA growing-stock multiplier for natural forest (1)
 pm_lambda_pla(i)                     Wood-only FRA growing-stock multiplier for plantations (1)
 i52_plant_asymptote(t_all,j)         Plantation carbon-curve vegc asymptote (tC per ha)- LPJmL-natural
 pm_gs_niche_fac(j)                   Per-cell wood-only vegc niche-floor factor for arid low-asymptote forest cells (1)
 p52_plant_asymp_agc_eff(clcl)        Effective plantation AGC asymptote target after anchor-mode masking (tC per ha)
 p52_lpjml_asymp_agc(clcl)            Plantation-area-weighted mean LPJmL AGC asymptote per climate class (tC per ha)
 p52_plant_asymp_factor(clcl)         Per-class plantation carbon-asymptote re-levelling factor - observed plateau over LPJmL (1)

;

equations
  q52_emis_co2_actual(i,emis_oneoff)                  Calculation of annual CO2 emissions (Tg per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq52_emis_co2_actual(t,i,emis_oneoff,type) Calculation of annual CO2 emissions (Tg per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
