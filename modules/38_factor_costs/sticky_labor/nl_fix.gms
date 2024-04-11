*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

v38_laborhours_need.fx(j,kcr) =  v38_laborhours_need.l(j,kcr);
v38_capital_need.fx(j,kcr,mobil38) =  v38_capital_need.l(j,kcr,mobil38);

* release v38_relax_CES_lp for linear version of MAgPIE
v38_relax_CES_lp.l(j,kcr) = 0;
v38_relax_CES_lp.lo(j,kcr) = -Inf;
v38_relax_CES_lp.up(j,kcr) = Inf;
