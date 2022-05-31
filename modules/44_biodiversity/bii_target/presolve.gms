*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if(m_year(t) >= s44_bii_start_year,
	if(s44_bii_target <> -Inf,
* The lower bound for `v44_bii` used in equation `q44_bii_target` depends on the current level multiplied with the annual growth rate in `s44_bii_target`.
		p44_bii_target(t,biome44)$(sum(j, f44_biome(j,biome44)) > 0) = min(v44_bii.l(biome44) * (1 + s44_bii_target * m_timestep_length),s44_bii_max_lower_bound);
* The lower bound of `v44_bii` is set to the current level in case of a positive annual growth rate to avoid a reduction of BII in combination with `v44_bii_missing`.
		v44_bii.lo(biome44)$(s44_bii_target >= 0) = v44_bii.l(biome44);
	);
);

display p44_bii_target;
