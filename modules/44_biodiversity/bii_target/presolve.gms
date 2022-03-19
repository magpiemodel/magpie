*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*v44_bv_slack.fx(j) = 0;

if (m_year(t) <= s44_start_year,
	v44_bv_slack.fx = 0;
*	v44_bv_glo.lo = 0;
else
*	v44_bv_glo.lo = v44_bv_glo.l + 0.0005 * m_timestep_length;
*	v44_bv_glo.lo$(v44_bv_glo.lo > 1) = 1;
);
