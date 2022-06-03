*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if(m_year(t) = s44_start_year AND s44_bii_target > 0,
* The start value for the linear interpolation is the BII at biome level in the start year.
	p44_start_value(biome44) = v44_bii.l(biome44);
* The target value is the start value scaled with the ratio of the global BII target `s44_bii_target` and global BII level in the start year
	p44_target_value(biome44) = (s44_bii_target / (sum((j,potnatveg,landcover44), vm_bv.l(j,landcover44,potnatveg)) / sum((j,land), pcm_land(j,land)))) * v44_bii.l(biome44);
* Linear increase of BII target values at biome level from start year to target year, and constant values thereafter.
	p44_bii_target(t2,biome44) = p44_start_value(biome44) + ((m_year(t2)-s44_start_year) / (s44_target_year-s44_start_year)) * (p44_target_value(biome44)-p44_start_value(biome44));
	p44_bii_target(t2,biome44)$(m_year(t2) > s44_target_year) = p44_target_value(biome44);
	p44_bii_target(t2,biome44)$(v44_bii.l(biome44) >= p44_target_value(biome44)) = v44_bii.l(biome44);
	p44_bii_target(t2,biome44)$(m_year(t2) < s44_start_year) = 0;
	p44_bii_target(t2,biome44)$(sum(j, f44_biome(j,biome44)) = 0) = 0;
* The lower bound of `v44_bii` is set to the current level if the current level of a biome is above the target to avoid a reduction of BII in combination with `v44_bii_missing`.
	v44_bii.lo(biome44)$(v44_bii.l(biome44) >= p44_target_value(biome44)) = v44_bii.l(biome44);
	display p44_bii_target;
);

