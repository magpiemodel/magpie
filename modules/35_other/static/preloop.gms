*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*fix other land
v35_land.fx(j,"new",si) = 0;
v35_land.fx(j,"grow",si) = 0;
v35_land.fx(j,"old",si) = pcm_land(j,"other",si);
vm_land.fx(j,"other",si) = sum(land35, v35_land.l(j,land35,si));

vm_landdiff_other.fx = 0;

pm_recovered_forest(t,j,ac,si) = 0;
