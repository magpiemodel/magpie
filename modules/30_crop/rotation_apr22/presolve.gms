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

* only activate constraints which are binding
rotamax_red30(rotamax30) = yes$(i30_rotation_max_shr(t,rotamax30) < 1);
rotamin_red30(rotamin30) = yes$(i30_rotation_min_shr(t,rotamin30) > 0);

vm_rotation_penalty.fx(i)=0;

p30_betr_min_shr(t,j) = p30_betr_scenario_fader(t) * s30_betr_min_shr;
