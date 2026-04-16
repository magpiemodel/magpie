*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' Growing stock calibration of secdforest and plantation growth curves.
*' For each region, find k (growth rate in Chapman-Richards equation) such that
*' the area-weighted growing stock matches FRA targets.
*'   - Secdforest: uses GFAD age distribution (im_forest_ageclass from module 28)
*'   - Plantations: assumes uniform age distribution across all age classes
*'
*' This runs in preloop (after module 28 preloop has populated im_forest_ageclass).
*'
*' Conversion chain: C_density (tC/ha) -> GS (m3/ha):
*'   GS = C_density / carbon_fraction * aboveground_fraction / BEF / D
*' where D = basic wood density (tDM/m3), BEF = biomass expansion factor

* Compute regional wood density (always needed, also used in M73 for demand conversion and cost regionalization)
im_vol_conv(i) = sum((cell(i,j), clcl), pm_climate_class(j,clcl) * f52_volumetric_conversion(clcl)) / sum(cell(i,j), 1);

if(s52_growingstock_calib = 1,

* Compute regional averages for conversion factors
  i52_bef_avg(i) = sum((cell(i,j), clcl), pm_climate_class(j,clcl) * fm_ipcc_bef(clcl)) / sum(cell(i,j), 1);

* Compute region-average m - kept fixed during calibration
  i52_m_avg_natveg(i) = sum((cell(i,j), clcl), pm_climate_class(j,clcl) * f52_growth_par(clcl,"m","natveg")) / sum(cell(i,j), 1);
  i52_m_avg_plant(i) = sum((cell(i,j), clcl), pm_climate_class(j,clcl) * f52_growth_par(clcl,"m","plantations")) / sum(cell(i,j), 1);

* ==========================================
* Secdforest k calibration (bisection)
*
* Calibrates k to match FRA NRF growing stock using the full GFAD age distribution
* (im_forest_ageclass), which includes primforest in the oldest age class (acx).
*
* Note: We do NOT decompose into primforest and secdforest separately because
* FRA primary forest GS data is highly uncertain (especially in the tropics),
* and the gap between LPJmL C_max and FRA observed GS reflects multiple factors
* (degradation, natural disturbance, species composition, spatial heterogeneity,
* measurement issues) that cannot be attributed to a single correction factor.
* ==========================================

* Initialize bisection bounds
  i52_k_low(i) = 0.001;
  i52_k_high(i) = 0.3;

  loop(iter52,
    i52_k_calib_secdf(i) = (i52_k_low(i) + i52_k_high(i)) / 2;

*   Area-weighted growing stock (m3/ha) with trial k using full GFAD age distribution
    i52_gs_current(i)$(sum((cell(i,j),ac), im_forest_ageclass(j,ac)) > 0) =
      sum((cell(i,j), ac),
        im_forest_ageclass(j,ac)
        * fm_carbon_density("y2025",j,"secdforest","vegc")
        * (1 - exp(-i52_k_calib_secdf(i) * (ord(ac)-1) * 5))**i52_m_avg_natveg(i)
      )
      / sum((cell(i,j), ac), im_forest_ageclass(j,ac))
      / sm_carbon_fraction
      * fm_aboveground_fraction("secdforest")
      / i52_bef_avg(i)
      / im_vol_conv(i)
    ;

    i52_k_low(i)$(i52_gs_current(i) < f52_fra_nrf_gs(i)) = i52_k_calib_secdf(i);
    i52_k_high(i)$(i52_gs_current(i) >= f52_fra_nrf_gs(i)) = i52_k_calib_secdf(i);
  );

* Overwrite secdforest carbon density with calibrated k
  pm_carbon_density_secdforest_ac(t_all,j,ac,"vegc") =
    fm_carbon_density(t_all,j,"secdforest","vegc")
    * (1 - exp(-sum(cell(i,j), i52_k_calib_secdf(i)) * (ord(ac)-1) * 5))**sum(cell(i,j), i52_m_avg_natveg(i));

* ==========================================
* Plantation k calibration (bisection)
* Uses actual plantation age distribution from module 32 (pc32_land)
* ==========================================

* Initialize bisection bounds
  i52_k_low(i) = 0.001;
  i52_k_high(i) = 0.3;

  loop(iter52,
    i52_k_calib_plant(i) = (i52_k_low(i) + i52_k_high(i)) / 2;

*   Area-weighted growing stock (m3/ha) at y2025 with trial k
    i52_gs_current_plant(i)$(sum((cell(i,j),ac), pm_land_plantation(j,ac)) > 0) =
      sum((cell(i,j), ac),
        pm_land_plantation(j,ac)
        * fm_carbon_density("y2025",j,"secdforest","vegc")
        * (1 - exp(-i52_k_calib_plant(i) * (ord(ac)-1) * 5))**i52_m_avg_plant(i)
      )
      / sum((cell(i,j), ac), pm_land_plantation(j,ac))
      / sm_carbon_fraction
      * fm_aboveground_fraction("forestry")
      / i52_bef_avg(i)
      / im_vol_conv(i)
    ;

    i52_k_low(i)$(i52_gs_current_plant(i) < f52_fra_pla_gs(i)) = i52_k_calib_plant(i);
    i52_k_high(i)$(i52_gs_current_plant(i) >= f52_fra_pla_gs(i)) = i52_k_calib_plant(i);
  );

* Log growing stock calibration results
  put_utility "log" / "Growing stock calibration to FRA 2025 (m3/ha):";
  put_utility "log" / "         NRF (nat.forest)    plantation";
  put_utility "log" / "       target  achieved    target  achieved";
  loop(i,
    put_utility "log" / "  " i.tl:3 f52_fra_nrf_gs(i):8:1 i52_gs_current(i):8:1 "  " f52_fra_pla_gs(i):8:1 i52_gs_current_plant(i):8:1;
  );

* Recompute plantation carbon density with calibrated k
  pm_carbon_density_plantation_ac(t_all,j,ac,"vegc") =
    fm_carbon_density(t_all,j,"secdforest","vegc")
    * (1 - exp(-sum(cell(i,j), i52_k_calib_plant(i)) * (ord(ac)-1) * 5))**sum(cell(i,j), i52_m_avg_plant(i));

);
