*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*fix bioenergy demand to given values
vm_dem_bioen.fx(i,kall) = 0;
vm_dem_bioen.fx(i,k) = f60_dem_1stgen_bioen(t,i,"%c60_1stgen_biodem%",k);

*relax boundaries for all crops which belong to kbe60 as their demand is
*calculated separately (see equations)
vm_dem_bioen.up(i,kbe60) = Inf;
vm_dem_bioen.lo(i,kbe60) = 0;

*fix bioenergy revenue to 0
vm_cost_bioen.fx(i) = 0;
