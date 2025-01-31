*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Update v44_bii.l based on vm_bv.l
loop(i,
  loop(biome44,
    if(i44_biome_area_reg(i,biome44) <= 0,
      v44_bii.fx(i,biome44) = 0;
      v44_bii_missing.fx(i,biome44) = 0;
    else
      v44_bii.l(i,biome44) = 
        sum((cell(i,j),landcover44,potnatveg), vm_bv.l(j,landcover44,potnatveg) * f44_rr_layer(j) * i44_biome_share(j,biome44))
        / i44_biome_area_reg(i,biome44);
    );
  );
);

if (m_year(t) = s44_start_year AND s44_bii_lower_bound > 0,
* The start value for the linear interpolation is the BII at biome level in the start year.
  p44_start_value(i,biome44) = v44_bii.l(i,biome44);
* The target value for the linear interpolation is the lower bound defined in `s44_bii_lower_bound`.
* Linear increase of BII target values at biome level from start year to target year, and constant values thereafter.
  p44_bii_lower_bound(t2,i,biome44) = p44_start_value(i,biome44) + ((m_year(t2) - s44_start_year) / (s44_target_year - s44_start_year)) * (s44_bii_lower_bound - p44_start_value(i,biome44));
  p44_bii_lower_bound(t2,i,biome44)$(m_year(t2) > s44_target_year) = s44_bii_lower_bound;
* Avoid implausible values
  p44_bii_lower_bound(t2,i,biome44)$(p44_bii_lower_bound(t2,i,biome44) >= 1) = 1;
  p44_bii_lower_bound(t2,i,biome44)$(m_year(t2) < s44_start_year) = 0;
  p44_bii_lower_bound(t2,i,biome44)$(i44_biome_area_reg(i,biome44) <= 0) = 0;
);

if (m_year(t) <= sm_fix_SSP2,
 v44_bii.lo(i,biome44) = 0;
else
  v44_bii.lo(i,biome44) = p44_bii_lower_bound(t,i,biome44);
  if(c44_bii_decrease = 0,
    v44_bii.lo(i,biome44)$(v44_bii.l(i,biome44) >= s44_bii_lower_bound) = v44_bii.l(i,biome44);   
  );
);

