*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' First, all 2nd generation bioenergy area is fixed to zero, irrespective of type and
*' rainfed/irrigation.
vm_area.fx(j,kbe30,w)=0;
*' Second, the bounds for 2nd generation bioenergy area are released depending on
*' the dynamic sets bioen_type_30 and bioen_water_30.
*' SSP2 default settings are used for the historic period.
if(m_year(t) <= sm_fix_SSP2,
  vm_area.up(j,kbe30,"rainfed") = Inf;
else
  vm_area.up(j,bioen_type_30,bioen_water_30) = Inf;
);
*' @stop

*' @code
*' Minimum semi-natural vegetation (SNV) share is fading in after 2020
p30_snv_shr(t,j) = p30_snv_scenario_fader(t) *
  (s30_snv_shr * sum(cell(i,j), p30_country_snv_weight(i))
  + s30_snv_shr_noselect * sum(cell(i,j), 1-p30_country_snv_weight(i)));

*' Cropland relocation in response to SNV policy is based on exogeneous land
*' cover information from the Copernicus Global Land Service (@buchhorn_copernicus_2020).
*' The rate of the policy implementation is derived based
*' on the difference of scenario fader values in consecutive time steps
p30_snv_relocation(t,j) = (p30_snv_scenario_fader(t) - p30_snv_scenario_fader(t-1)) *
  (i30_snv_relocation_target(j) * sum(cell(i,j), p30_country_snv_weight(i))
  + s30_snv_shr_noselect * sum(cell(i,j), 1-p30_country_snv_weight(i)));
*' The following lines take care of mismatches in the input
*' data (derived from satellite imagery) and in
*' cases of cropland reduction
p30_max_snv_relocation(t,j) = p30_snv_shr(t,j) * (p30_snv_scenario_fader(t) - p30_snv_scenario_fader(t-1)) * pcm_land(j,"crop");
p30_snv_relocation(t,j)$(p30_snv_relocation(t, j) > p30_max_snv_relocation(t,j)) = p30_max_snv_relocation(t,j);

*' Area potentially available for cropping
p30_avl_cropland(t,j) = f30_avl_cropland(j,"%c30_marginal_land%") * (1 - p30_snv_shr(t,j));
*' @stop

* only activate constraints which are binding
rotamax_red30(rotamax30) = yes$(i30_rotation_max_shr(t,rotamax30) < 1);
rotamin_red30(rotamin30) = yes$(i30_rotation_min_shr(t,rotamin30) > 0);

vm_rotation_penalty.fx(i)=0;
