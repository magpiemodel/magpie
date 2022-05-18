*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v44_bii_glo.l = 0.75;
v44_bii_reg.l(i) = 0.75;
v44_bii_cell.l(j) = 0.75;
v44_bii_realm.l(realm) = 0.75;

v44_bii_realm.fx(realm)$(sum(j, f44_realm(j,realm)) = 0) = 0;
v44_bii_realm_missing.fx(realm)$(sum(j, f44_realm(j,realm)) = 0) = 0;
p44_bii_realm_target(t_all,realm) = 0;


