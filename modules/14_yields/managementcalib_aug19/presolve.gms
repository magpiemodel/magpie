*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** EOF presolve.gms ***

* calculate carbon density

*** YIELDS

*` `pm_carbon_density_plantation_ac` for vegetation Carbon is above- and belowground
*' carbon density. We convert Carbon density in tC/ha to tDM/ha by using carbon
*' fraction of `s14_carbon_fraction` in tC/tDM. For assessing wood harvesting
*' we need only aboveground biomass information, therefore we multiply with
*' aboveground `f14_aboveground_fraction`. Additionally, we divide aboveground
*' tree biomass by biomass conversion and expansion (BCE) factor to get stem
*' biomass in tDM/ha.

*` @code

pm_timber_yield(t,j,ac,"forestry") =
    (
     pm_carbon_density_plantation_ac(t,j,ac,"vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("forestry")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"plantations"))
    )
    ;

pm_timber_yield(t,j,ac,"primforest") =
    (
     fm_carbon_density(t,j,"primforest","vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("primforest")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

pm_timber_yield(t,j,ac,"secdforest") =
    (
     pm_carbon_density_secdforest_ac(t,j,ac,"vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("secdforest")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

pm_timber_yield(t,j,ac,"other") =
    (
     pm_carbon_density_other_ac(t,j,ac,"vegc")
     / s14_carbon_fraction
     * f14_aboveground_fraction("other")
     / sum(clcl, pm_climate_class(j,clcl) * f14_ipcc_bce(clcl,"natveg"))
    )
    ;

*` @stop

** Hard constraint to always have a positive number in pm_timber_yield
pm_timber_yield(t,j,ac,land_timber) = pm_timber_yield(t,j,ac,land_timber)$(pm_timber_yield(t,j,ac,land_timber) > 0) + 0.0001$(pm_timber_yield(t,j,ac,land_timber) = 0);
** Put yields to 0 where they dont exceed a minimum yield for harvest
pm_timber_yield(t,j,ac,land_natveg)$(pm_timber_yield(t,j,ac,land_natveg) < s14_minimum_wood_yield) = 0;


** Share of cropland within conservation priority area
p14_cropland_consv_shr(t,j) = 0;

if(c14_croparea_consv = 1,
  p14_cropland_consv_shr(t,j)$(pcm_land(j,"crop") > 0) = sum(consv_type, pm_land_conservation(t,j,"crop",consv_type))/pcm_land(j,"crop");
  p14_cropland_consv_shr(t,j)$(p14_cropland_consv_shr(t,j) > 1) = 1;

  if(s14_croparea_consv_shr > 0 AND m_year(t) >= s14_croparea_consv_start,
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by available cropland area.
    p14_country_weight(i) = sum(i_to_iso(i,iso), p14_country_switch(iso) * pm_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), pm_avl_cropland_iso(iso));
    p14_cropland_consv_shr(t,j) = i14_croparea_consv_fader(t) *
    (s14_croparea_consv_shr * sum(cell(i,j), p14_country_weight(i))
    + s14_croparea_consv_shr_noselect * sum(cell(i,j), 1-p14_country_weight(i)));

  );

);

p14_country_wght_supreg(h) = sum((i_to_iso(i,iso), supreg(h,i)), p14_country_switch(iso) * pm_avl_cropland_iso(iso)) / sum((i_to_iso(i,iso), supreg(h,i)), pm_avl_cropland_iso(iso));

p14_croparea_consv_tau_factor(h) = (s14_croparea_consv_tau_factor * p14_country_wght_supreg(h)
                            + s14_croparea_consv_tau_factor_noselect * (1-p14_country_wght_supreg(h)));

if (m_year(t) < s14_croparea_consv_start,
  p14_tau_consv(h,"crop") =  pcm_tau(h,"crop");

elseif c14_croparea_consv_tau_increase = 1 AND m_year(t) >= s14_croparea_consv_start,
  p14_tau_consv(h,"crop") =  p14_croparea_consv_tau_factor(h) * pcm_tau(h,"crop");

elseif c14_croparea_consv_tau_increase = 0 AND m_year(t) = s14_croparea_consv_start
  p14_tau_consv(h,"crop") =  p14_croparea_consv_tau_factor(h) * pcm_tau(h,"crop");

);
