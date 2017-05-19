*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p35_protect_other(t,i) = 0;
p35_protect_other(t,i)$(fm_forest_change(t,i) < 0 AND s35_protect_other = 1) = 1;

**interface boundaries
vm_land.lo(j,"other",si) = 0;
vm_land.up(j,"other",si) = Inf;

vm_carbon_stock.lo(j,"other",c_pools) = 0;
vm_carbon_stock.up(j,"other",c_pools) = Inf;

*calculate age class share for each forest land type
ac_land35(ac,land35) = no;
ac_land35(ac,"new")  = yes$(ord(ac) = 1);
ac_land35(ac,"grow") = yes$(ord(ac) > 1 AND ord(ac) < card(ac));
ac_land35(ac,"old")  = yes$(ord(ac) = card(ac));

i35_land(j,ac,si) = 0;
i35_land(j,"acx",si) = pcm_land(j,"other",si);

pm_recovered_forest(t,j,ac,si) = 0;
