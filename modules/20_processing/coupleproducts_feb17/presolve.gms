*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


vm_dem_processing.fx(i,knpr)=0;
vm_processing_costs.fx(i)=0;

vm_secondary_overproduction.fx(i2,kall,kpr)=0;
vm_secondary_overproduction.up(i2,ksd,kpr)=Inf;

v20_secondary_substitutes.fx(i,ksd,kpr)=0;
v20_secondary_substitutes.up(i,"brans",kcereals20)=Inf;
v20_secondary_substitutes.up(i,"oils",kcereals20)=Inf;

* allowing only cereals and oils as substitutes for brans, germoil and branoil
v20_dem_processing.fx(i2,"substitutes",kpr)=0;
v20_dem_processing.up(i2,"substitutes",kcereals20)=Inf;
v20_dem_processing.up(i2,"substitutes","oils")=Inf;