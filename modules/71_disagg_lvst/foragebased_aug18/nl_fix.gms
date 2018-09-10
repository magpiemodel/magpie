*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

v71_feed_balanceflow.lo(j,kli_rum,kforage)$(sum(cell(i,j),fm_feed_balanceflow(t,i,kli_rum,kforage)) > 0) = 0;
v71_feed_balanceflow.up(j,kli_rum,kforage)$(sum(cell(i,j),fm_feed_balanceflow(t,i,kli_rum,kforage)) < 0) = 0;
v71_feed_balanceflow.fx(j,kli_rum,kforage)$(sum(cell(i,j),fm_feed_balanceflow(t,i,kli_rum,kforage)) = 0) = 0;
v71_feed_balanceflow.fx(j,kli_rum,"pasture")$(pcm_land(j,"past")=0) = 0;
v71_feed_balanceflow.fx(j,kli_rum,"foddr")$(pcm_land(j,"crop")=0) = 0;

s71_lp_fix=1;