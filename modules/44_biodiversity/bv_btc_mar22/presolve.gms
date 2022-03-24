*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if (m_year(t) <= s44_start_year,
	vm_cost_bv_loss.fx(j) = 0;
else
	vm_cost_bv_loss.lo(j) = -Inf;
	vm_cost_bv_loss.up(j) = Inf;
);
