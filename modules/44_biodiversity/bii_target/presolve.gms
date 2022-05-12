*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_cost_bv_loss.fx(j) = 0;

if((m_year(t) >= s44_bii_start_year),
	if((s44_bii_change_annual = -Inf),
		v44_bii_glo.lo = 0;
	else
		v44_bii_glo.lo = v44_bii_glo.l * (1 + s44_bii_change_annual * m_timestep_length);
	);
);

display v44_bii_glo.lo;
