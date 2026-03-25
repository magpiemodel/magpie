*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Release the fix on vm_cost_trade_feasibility each time step so the solver
* can freely set its level via q21_cost_trade_feasibility.

vm_cost_trade_feasibility.lo(i) = 0;
vm_cost_trade_feasibility.up(i) = Inf;
