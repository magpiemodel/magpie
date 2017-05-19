*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

vm_cost_fore.fx(i) = 0;
vm_cdr_aff.fx(j,emis_source_co2_forestry) = 0;

*fix forestry land
v32_land.fx(j,"new",si) = 0;
v32_land.fx(j,"prot",si) = 0;
v32_land.fx(j,"grow",si) = 0;
v32_land.fx(j,"old",si) = pcm_land(j,"forestry",si);
vm_land.fx(j,"forestry",si) = sum(land32, v32_land.l(j,land32,si));

vm_landdiff_forestry.fx = 0;

*** EOF preloop.gms ***
