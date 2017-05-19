*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

f33_ifft(j,si)$(f33_ifft(j,si) > pcm_land(j,"forest",si)) = pcm_land(j,"forest",si);

v33_land.fx(j,"ifft",si) = f33_ifft(j,si);
v33_land.fx(j,"modnat",si) = pcm_land(j,"forest",si) - v33_land.l(j,"ifft",si);
vm_land.fx(j,"forest",si) =  sum(land33, v33_land.l(j,land33,si));

vm_landdiff_forest.fx = 0;

