*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @code
*' Minimum semi-natural vegetation (SNV) share is fading in after 2020
p29_snv_shr(t,j) = i29_snv_scenario_fader(t) *
  (s29_snv_shr * sum(cell(i,j), p29_country_weight(i))
  + s29_snv_shr_noselect * sum(cell(i,j), 1-p29_country_weight(i)));

*' Cropland relocation in response to SNV policy is based on exogeneous land
*' cover information from the Copernicus Global Land Service (@buchhorn_copernicus_2020).
*' The rate of the policy implementation is derived based
*' on the difference of scenario fader values in consecutive time steps
p29_snv_relocation(t,j) = (i29_snv_scenario_fader(t) - i29_snv_scenario_fader(t-1)) *
  (i29_snv_relocation_target(j) * sum(cell(i,j), p29_country_weight(i))
  + s29_snv_shr_noselect * sum(cell(i,j), 1-p29_country_weight(i)));
*' The following lines take care of mismatches in the input
*' data (derived from satellite imagery from the Copernicus
*' Global Land Service (@buchhorn_copernicus_2020)) and in
*' cases of cropland reduction
p29_max_snv_relocation(t,j) = p29_snv_shr(t,j) * (i29_snv_scenario_fader(t) - i29_snv_scenario_fader(t-1)) * pcm_land(j,"crop")
                              - vm_treecover.l(j);
p29_max_snv_relocation(t,j)$(p29_max_snv_relocation(t,j) < 1e-6) = 0;  
p29_snv_relocation(t,j)$(p29_snv_relocation(t, j) > p29_max_snv_relocation(t,j)) = p29_max_snv_relocation(t,j);

*' Area potentially available for cropping
p29_avl_cropland(t,j) = f29_avl_cropland(j,"%c29_marginal_land%") * (1 - p29_snv_shr(t,j));
*' @stop

