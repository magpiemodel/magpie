*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if(m_year(t) >= s44_bii_start_year,
	if(s44_bii_mode = 0 AND s44_bii_change_annual <> -Inf,
		v44_bii_glo.lo = min(v44_bii_glo.l * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
	elseif s44_bii_mode = 1 AND s44_bii_change_annual <> -Inf,
		v44_bii_reg.lo(i) = min(v44_bii_reg.l(i) * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
	elseif s44_bii_mode = 2 AND s44_bii_change_annual <> -Inf,
		v44_bii_cell.lo(j) = min(v44_bii_cell.l(j) * (1 + s44_bii_change_annual * m_timestep_length),s44_bii_max_lower_bound);
	);
);



display v44_bii_glo.lo;
display v44_bii_reg.lo;
display v44_bii_cell.lo;
