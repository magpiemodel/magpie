*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

v71_feed_balanceflow.lo(j,kforage)$(sum((cell(i,j),kli_rum),fm_feed_balanceflow(t,i,kli_rum,kforage)) > 0) = 0;
v71_feed_balanceflow.up(j,kforage)$(sum((cell(i,j),kli_rum),fm_feed_balanceflow(t,i,kli_rum,kforage)) < 0) = 0;
v71_feed_balanceflow.fx(j,kforage)$(sum((cell(i,j),kli_rum),fm_feed_balanceflow(t,i,kli_rum,kforage)) = 0) = 0;
v71_feed_balanceflow.fx(j,"pasture")$(pcm_land(j,"past")=0) = 0;
v71_feed_balanceflow.fx(j,"foddr")$(pcm_land(j,"crop")=0) = 0;
