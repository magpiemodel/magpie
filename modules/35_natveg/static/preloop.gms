*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*fix other land
v35_other.fx(j,"new") = 0;
v35_other.fx(j,"grow") = 0;
v35_other.fx(j,"old") = pcm_land(j,"other");
vm_land.fx(j,"other") = sum(land35, v35_other.l(j,land35));

vm_landdiff_other.fx = 0;

pm_recovered_forest(t,j,ac) = 0;
