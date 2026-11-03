*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' Growing-stock calibration of secdforest and plantation WOOD only (carbon is never bent). Per region an
*' analytic wood multiplier lambda = FRA growing-stock target / area-weighted growing stock of the
*' observation-based carbon curve, applied to im_growing_stock in module 14:
*'   - Secdforest (pm_lambda_nrf): weighted by the GFAD/GAMI age distribution (im_forest_ageclass, module 28)
*'   - Plantations (pm_lambda_pla): sampled at the cellular rotation age (pm_rotation_cellular_estb, module 32)
*' Runs in preloop after module 28 populates im_forest_ageclass. Conversion C_density (tC/ha) -> GS (m3/ha):
*'   GS = C_density / carbon_fraction * aboveground_fraction / BEF / D  (D = wood density tDM/m3, BEF = expansion factor)

* Compute regional wood density (always needed, also used in M73 for demand conversion and cost regionalization)
im_vol_conv(i) = sum((cell(i,j), clcl), pm_climate_class(j,clcl) * f52_volumetric_conversion(clcl)) / sum(cell(i,j), 1);

* Default: identity wood multiplier (no wood recalibration when growing-stock calib is off)
pm_lambda_nrf(i) = 1;
pm_lambda_pla(i) = 1;
pm_gs_niche_fac(j) = 1;

* Plantation carbon-asymptote anchor (observed managed plateau). The plantation vegc curve is built (52
* start.gms) on the LPJmL natural old-growth ceiling (fm_carbon_density secdforest) - too HIGH for managed
* monocultures in the tropics, too LOW in temperate/boreal (Bukoski et al. 2022). When s52_plant_asymp_anchor>0
* the curve is re-levelled per climate class by (observed plateau f52_plant_asymp_agc / plantation-area-weighted
* mean LPJmL AGC), re-anchoring the biome MEAN while preserving the LPJmL cell pattern. PLANTATIONS only; runs
* before the lambda block so lambda compensates and reported growing stock stays FRA-pinned. 0=off, 1=tropical-only, 2=all Bukoski biomes.
p52_plant_asymp_agc_eff(clcl) = 0;
if(s52_plant_asymp_anchor = 1, p52_plant_asymp_agc_eff(clcl_trop52) = f52_plant_asymp_agc(clcl_trop52); );
if(s52_plant_asymp_anchor = 2, p52_plant_asymp_agc_eff(clcl)        = f52_plant_asymp_agc(clcl); );

* Plantation-area-weighted mean LPJmL AGC asymptote per climate class. Reference year y2025 to match
* the lambda block below (FRA 2025 calibration year); pm_land_plantation is the static base-year estate.
p52_lpjml_asymp_agc(clcl)$(
    sum(j, sum(ac, pm_land_plantation(j,ac)) * pm_climate_class(j,clcl)) > 0) =
    sum(j,
        sum(ac, pm_land_plantation(j,ac)) * pm_climate_class(j,clcl)
      * fm_carbon_density("y2025",j,"secdforest","vegc") * fm_aboveground_fraction("forestry"))
  / sum(j,
        sum(ac, pm_land_plantation(j,ac)) * pm_climate_class(j,clcl));

* Re-levelling factor (default 1; only where an anchor target and a positive LPJmL mean exist)
p52_plant_asymp_factor(clcl) = 1;
p52_plant_asymp_factor(clcl)$(p52_plant_asymp_agc_eff(clcl) > 0 and p52_lpjml_asymp_agc(clcl) > 0) =
    p52_plant_asymp_agc_eff(clcl) / p52_lpjml_asymp_agc(clcl);

* Rescale the plantation vegc curve by the per-cell effective factor (climate-share weighted).
* Multiplying A*shape by the factor = (A*factor)*shape: asymptote re-levelled, shape untouched.
pm_carbon_density_plantation_ac(t_all,j,ac,"vegc") =
    pm_carbon_density_plantation_ac(t_all,j,ac,"vegc")
  * sum(clcl, pm_climate_class(j,clcl) * p52_plant_asymp_factor(clcl));

if(s52_growingstock_calib = 1,

* Compute regional averages for conversion factors
  i52_bef_avg(i) = sum((cell(i,j), clcl), pm_climate_class(j,clcl) * fm_ipcc_bef(clcl)) / sum(cell(i,j), 1);

* Wood-only niche floor (s52_gs_niche_floor, tC/ha): per-cell factor lifting arid low-asymptote cells' curve so
* mature stock >= the floor, applied identically to the lambda denominators (below) and the harvest base (module
* 14). Shape-preserving (one factor, no young-class inflation); fires only where the LPJmL asymptote is implausibly low. 0 disables.
  pm_gs_niche_fac(j)$(s52_gs_niche_floor > 0 and fm_carbon_density("y2025",j,"secdforest","vegc") > 1e-6) =
    max(1, s52_gs_niche_floor / fm_carbon_density("y2025",j,"secdforest","vegc"));

* Natural forest (NRF) wood multiplier (lambda). Reference growing stock (m3/ha) = area-weighted mean over the
* forest age distribution (im_forest_ageclass) of the secdforest carbon curve converted to volume; lambda scales
* it to the FRA target.
  i52_gs_curve_nrf(i)$(sum((cell(i,j),ac), im_forest_ageclass(j,ac)) > 0) =
    sum((cell(i,j), ac),
      im_forest_ageclass(j,ac)
      * pm_carbon_density_secdforest_ac("y2025",j,ac,"vegc")
      * pm_gs_niche_fac(j)
    )
    / sum((cell(i,j), ac), im_forest_ageclass(j,ac))
    / sm_carbon_fraction
    * fm_aboveground_fraction("secdforest")
    / i52_bef_avg(i)
    / im_vol_conv(i)
  ;

  pm_lambda_nrf(i)$(i52_gs_curve_nrf(i) > 0) = f52_fra_nrf_gs(i) / i52_gs_curve_nrf(i);

* Plantation wood multiplier (lambda). Plantation carbon curve sampled at the cellular ROTATION age
* (pm_rotation_cellular_estb, module 32), area-weighted by plantation cell area. Rotation-age is the correct
* reference because harvest samples im_growing_stock(forestry) at exactly that age (module 32 presolve): lambda
* is set to FRA / (growing stock at the rotation age), so the harvested growing stock reproduces the FRA target
* exactly.
  i52_gs_curve_pla(i)$(sum(cell(i,j), sum(ac, pm_land_plantation(j,ac))) > 0) =
    sum(cell(i,j),
      sum(ac, pm_land_plantation(j,ac))
      * sum(ac2$(ac2.off = pm_rotation_cellular_estb("y2025",j)),
            pm_carbon_density_plantation_ac("y2025",j,ac2,"vegc"))
      * pm_gs_niche_fac(j)
    )
    / sum(cell(i,j), sum(ac, pm_land_plantation(j,ac)))
    / sm_carbon_fraction
    * fm_aboveground_fraction("forestry")
    / i52_bef_avg(i)
    / im_vol_conv(i)
  ;

  pm_lambda_pla(i)$(i52_gs_curve_pla(i) > 0) = f52_fra_pla_gs(i) / i52_gs_curve_pla(i);

* Cap lambda at the biomass expansion factor (BEF): lambda > BEF would harvest more stemwood than the
* stand aboveground biomass holds. It occurs where the FRA growing-stock target exceeds the LPJmL biomass
* (e.g. arid or intensively managed forest regions). The hard cap enforces this physical limit; the capped
* regions then no longer reproduce FRA GS.
  if(s52_lambda_bef_cap = 1,
    loop(i$(pm_lambda_nrf(i) > i52_bef_avg(i)),
      put_utility "log" / "  lambda_nrf capped at BEF in " i.tl:3 ": " pm_lambda_nrf(i):8:3 " -> " i52_bef_avg(i):8:3;
    );
    loop(i$(pm_lambda_pla(i) > i52_bef_avg(i)),
      put_utility "log" / "  lambda_pla capped at BEF in " i.tl:3 ": " pm_lambda_pla(i):8:3 " -> " i52_bef_avg(i):8:3;
    );
    pm_lambda_nrf(i)$(pm_lambda_nrf(i) > i52_bef_avg(i)) = i52_bef_avg(i);
    pm_lambda_pla(i)$(pm_lambda_pla(i) > i52_bef_avg(i)) = i52_bef_avg(i);
  );

* Log wood-multiplier (lambda) calibration to FRA 2025
  put_utility "log" / "Wood multiplier (lambda) calibration to FRA 2025 (m3/ha):";
  put_utility "log" / "         NRF (nat.forest)               plantation";
  put_utility "log" / "     target   curve GS  lambda     target   curve GS  lambda";
  loop(i,
    put_utility "log" / "  " i.tl:3 f52_fra_nrf_gs(i):8:1 i52_gs_curve_nrf(i):8:1 pm_lambda_nrf(i):8:3 "  " f52_fra_pla_gs(i):8:1 i52_gs_curve_pla(i):8:1 pm_lambda_pla(i):8:3;
  );

);
