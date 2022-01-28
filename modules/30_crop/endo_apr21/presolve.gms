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

crpmax30(crp30) = yes$(f30_rotation_max_shr(crp30) < 1);
crpmin30(crp30) = yes$(f30_rotation_min_shr(crp30) > 0);

*' @code
*' Set aside cropland policy is fading in after 2020
p30_avl_cropland(t,j) = f30_avl_cropland(j,"%c30_marginal_land%") * 
	(1 - f30_set_aside_fader(t,"%c30_set_aside_target%") * 
	(s30_set_aside_shr * sum(cell(i,j), p30_region_setaside_shr(i)) 
	+ s30_set_aside_shr_noselect * sum(cell(i,j), 1-p30_region_setaside_shr(i)))); 
*' @stop
