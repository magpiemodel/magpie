*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$ifthen "%c30_bioen_type%" == "all" bioen_type_30(kbe30) = yes;
$else bioen_type_30("%c30_bioen_type%") = yes;
$endif

$ifthen "%c30_bioen_water%" == "all" bioen_water_30(w) = yes;
$else bioen_water_30("%c30_bioen_water%") = yes;
$endif

*' @code
*' First, all 2nd generation bioenergy area is fixed to zero, irrespective of type and
*' rainfed/irrigation.
vm_area.fx(j,kbe30,w)=0;
*' Second, the bounds for 2nd generation bioenergy area are released depending on
*' the dynamic sets bioen_type_30 and bioen_water_30.
vm_area.up(j,bioen_type_30,bioen_water_30)=Inf;
*' @stop

*' @code
*' Minimum semi-natural vegetation (SNV) share is fading in after 2020
p30_avl_cropland(t,j) = f30_avl_cropland(j,"%c30_marginal_land%") *
	(1 - f30_scenario_fader(t,"%c30_snv_target%") *
	(s30_snv_shr * sum(cell(i,j), p30_region_snv_shr(i))
	+ s30_snv_shr_noselect * sum(cell(i,j), 1-p30_region_snv_shr(i))));
*' @stop

* only activate constraints which are binding
rotamax_red30(rotamax30) = yes$(i30_rotation_incentives(t,rotamax30) > 0);
rotamin_red30(rotamin30) = yes$(i30_rotation_incentives(t,rotamin30) > 0);
