*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*maybe move this part to preprocessing?
*calculate forest and other land based on carbon density threshold; forest if carbon density > 20 tC/ha, other land if carbon density <= 20 tC/ha
pm_land_start(j,land,si) = f10_land(j,land,si);

*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
pm_land_start(j,land,si)$(pm_land_start(j,land,si)<0) = 0;
pcm_land(j,land,si) = pm_land_start(j,land,si);