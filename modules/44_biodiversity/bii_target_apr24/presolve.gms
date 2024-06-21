*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* The start value for the linear interpolation is the BII at biome level in the start year.
p44_start_value(i,biome44)$(m_year(t) = s44_start_year) = v44_bii.l(i,biome44);
* The target value for the linear interpolation is the lower bound defined in `s44_bii_lower_bound`.
p44_target_value(i,biome44) = s44_bii_lower_bound;

if (m_year(t) <= sm_fix_SSP2,
 v44_bii.lo(i,biome44) = 0;
else
* Linear increase of BII target values at biome level from start year to target year, and constant values thereafter.
  p44_bii_lower_bound(t2,i,biome44) = p44_start_value(i,biome44) + ((m_year(t2) - s44_start_year) / (s44_target_year - s44_start_year)) * (p44_target_value(i,biome44) - p44_start_value(i,biome44));
  p44_bii_lower_bound(t2,i,biome44)$(m_year(t2) > s44_target_year) = p44_target_value(i,biome44);
  if(c44_bii_decrease = 0,
    p44_bii_lower_bound(t2,i,biome44)$(v44_bii.l(i,biome44) >= p44_target_value(i,biome44)) = v44_bii.l(i,biome44);   
  elseif c44_bii_decrease = 1,
    p44_bii_lower_bound(t2,i,biome44)$(v44_bii.l(i,biome44) >= p44_target_value(i,biome44)) = p44_target_value(i,biome44);
  );
  p44_bii_lower_bound(t2,i,biome44)$(p44_bii_lower_bound(t2,i,biome44) >= 1) = 1;
  p44_bii_lower_bound(t2,i,biome44)$(m_year(t2) < s44_start_year) = 0;
  p44_bii_lower_bound(t2,i,biome44)$(sum(cell(i,j), f44_biome(j,biome44)) = 0) = 0;
* The lower bound of `v44_bii` is set to `p44_bii_lower_bound` to avoid a reduction of BII in combination with `v44_bii_missing`.
  v44_bii.lo(i,biome44) = p44_bii_lower_bound(t,i,biome44);
  display p44_bii_lower_bound;
);
