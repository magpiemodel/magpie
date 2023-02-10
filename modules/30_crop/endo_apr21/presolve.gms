*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
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

*' No penalties or fallows exist in this realization
vm_rotation_penalty.fx(i)=0;
vm_fallow.fx(j)=0;

crpmax30(crp30) = yes$(f30_rotation_max_shr(crp30) < 1);
crpmin30(crp30) = yes$(f30_rotation_min_shr(crp30) > 0);

*' @code
*' Minimum semi-natural vegetation (SNV) share is fading in after 2020
p30_snv_shr(t,j) = p30_snv_scenario_fader(t) *
  (s30_snv_shr * sum(cell(i,j), p30_country_snv_weight(i))
  + s30_snv_shr_noselect * sum(cell(i,j), 1-p30_country_snv_weight(i)));

*' Area potentially available for cropping
p30_avl_cropland(t,j) = f30_avl_cropland(j,"%c30_marginal_land%") * (1 - p30_snv_shr(t,j));
*' @stop

if(m_year(t) <= sm_fix_SSP2,
  v30_crop_area.up(i) = Inf;
else
  v30_crop_area.up(i) = v30_crop_area.l(i) * (1 + s30_annual_max_growth) ** m_yeardiff(t);
);