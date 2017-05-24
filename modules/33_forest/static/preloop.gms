*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

f33_ifft(j)$(f33_ifft(j) > pcm_land(j,"forest")) = pcm_land(j,"forest");

v33_land.fx(j,"ifft") = f33_ifft(j);
v33_land.fx(j,"modnat") = pcm_land(j,"forest") - v33_land.l(j,"ifft");
vm_land.fx(j,"forest") =  sum(land33, v33_land.l(j,land33));

vm_landdiff_forest.fx = 0;

