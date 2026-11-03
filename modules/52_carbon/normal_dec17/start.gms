*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*age-class carbon density start values
pc52_carbon_density_start(t_all,j,"vegc") = 0;
pc52_carbon_density_start(t_all,j,"litc") = fm_carbon_density(t_all,j,"past","litc");

* ----------------------------
* Forestry
* ----------------------------

* Plantation carbon-curve asymptote (vegc): the LPJmL natural potential (secdforest ceiling). Module 52
* preloop optionally re-levels it per climate class to an observed managed plateau (s52_plant_asymp_anchor).
i52_plant_asymptote(t_all,j) = fm_carbon_density(t_all,j,"secdforest","vegc");

*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_plantation_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),i52_plant_asymptote(t_all,j),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","plantations")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","plantations")),(ord(ac)-1));

*calculate litter carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_plantation_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"secdforest","litc"),(ord(ac)-1));

* -----------------------------
* Natveg
* -----------------------------

*** Secondary forest
*calculate vegetation age-class carbon density in current time step with chapman richards equation
*** The naturally-regrowing rate k has already been pre-scaled by s52_natveg_growth_scalar in input.gms
*** (default 0.83 = p25 lower quartile of Robinson 2025 cell rates), consistently for every curve built
*** from "natveg" (this and other land below) and the natveg-derived other-planted curve. Same asymptote,
*** slower approach -> carbon only; the FRA wood multiplier pm_lambda_nrf (52 preloop) recomputes from this
*** curve, so secdforest wood stays FRA-pinned (module 14).
pm_carbon_density_secdforest_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"secdforest","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","natveg")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","natveg")),(ord(ac)-1));

*calculate litter carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_secdforest_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"secdforest","litc"),(ord(ac)-1));

*** Other planted forest (FRA "other planted"): a natveg-derived Chapman-Richards curve read from
*** f52_growth_par(clcl,{k,m},"other_planted") = the natveg curve with the SAME shape (m = m_natveg, so the same
*** establishment lag) and rate k = r x k_natveg (per-biome r), sharing the LPJmL-secdforest asymptote; cell-weighted like natveg. Its k
*** was pre-scaled (input.gms) and wood borrows pm_lambda_nrf, so the scaling cancels -> wood unchanged (carbon only).
pm_carbon_density_other_planted_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"secdforest","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","other_planted")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","other_planted")),(ord(ac)-1));
pm_carbon_density_other_planted_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"secdforest","litc"),(ord(ac)-1));

* Fallback value; overwritten by climate-zone-specific values in preloop
im_vol_conv(i) = 0.5;

*** Other land
*calculate vegetation age-class carbon density in current time step with chapman richards equation
*** Uses the "natveg" rate, pre-scaled by s52_natveg_growth_scalar (input.gms), so regrowth stays consistent
*** with secondary forest. Other land is not FRA-calibrated, so its wood follows this carbon curve directly.
pm_carbon_density_other_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","natveg")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","natveg")),(ord(ac)-1));

*calculate litter carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_other_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"other","litc"),(ord(ac)-1));
