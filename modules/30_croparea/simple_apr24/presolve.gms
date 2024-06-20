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

crpmax30(crp30) = yes$(f30_rotation_max_shr(crp30) < 1);
crpmin30(crp30) = yes$(f30_rotation_min_shr(crp30) > 0);

* create betr target and penalty scenario
i30_betr_target(t,j) = (1-i30_betr_scenario_fader(t)) * 
  (s30_betr_start * sum(cell(i,j), p30_country_weight(i))
  + s30_betr_start_noselect * sum(cell(i,j), 1-p30_country_weight(i)))
 + i30_betr_scenario_fader(t)  * 
  (s30_betr_target * sum(cell(i,j), p30_country_weight(i))
  + s30_betr_target_noselect * sum(cell(i,j), 1-p30_country_weight(i)));

if (m_year(t) <= s30_betr_scenario_start,
  i30_betr_penalty(t) = 0;
  v30_betr_missing.fx(j) = 0;
else
  i30_betr_penalty(t) = s30_betr_penalty;
  if (i30_betr_penalty(t) > 0,
    v30_betr_missing.lo(j) = 0;
    v30_betr_missing.up(j) = Inf;
  else
    v30_betr_missing.fx(j) = 0;
  );
);

*' Cropland growth constraint after SSP2 fix
if(m_year(t) <= sm_fix_SSP2,
  v30_crop_area.up(i) = Inf;
else
  v30_crop_area.up(i) = v30_crop_area.l(i) * (1 + s30_annual_max_growth) ** m_yeardiff(t);
);
