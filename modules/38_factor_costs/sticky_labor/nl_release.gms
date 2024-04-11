*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ### nl_release ###

v38_laborhours_need.lo(j,kcr) = 0.1 * v38_laborhours_need.l(j,kcr);
v38_laborhours_need.up(j,kcr) = 10 * v38_laborhours_need.l(j,kcr);
v38_capital_need.lo(j,kcr,mobil38) = 0.1 * v38_capital_need.l(j,kcr,mobil38);
v38_capital_need.up(j,kcr,mobil38) = 10 * v38_capital_need.l(j,kcr,mobil38);

* fix v38_relax_CES_lp to zero for non-linear version of MAgPIE
v38_relax_CES_lp.fx(j,kcr) = 0;
