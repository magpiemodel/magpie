*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

v71_feed_balanceflow.lo(j,kli_rum,kforage)$(sum(cell(i,j),fm_feed_balanceflow(t,i,kli_rum,kforage)) > 0) = 0;
v71_feed_balanceflow.up(j,kli_rum,kforage)$(sum(cell(i,j),fm_feed_balanceflow(t,i,kli_rum,kforage)) < 0) = 0;
v71_feed_balanceflow.fx(j,kli_rum,kforage)$(sum(cell(i,j),fm_feed_balanceflow(t,i,kli_rum,kforage)) = 0) = 0;
v71_feed_balanceflow.fx(j,kli_rum,kforage)$(pcm_land(j,"pasture")=0) = 0;