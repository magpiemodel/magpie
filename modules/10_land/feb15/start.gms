*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
pm_land_start(j,land) = f10_land("y1995",j,land);
pm_land_start(j,land)$(pm_land_start(j,land)<0) = 0;

pcm_land(j,land) = pm_land_start(j,land);
vm_land.l(j,land) = pcm_land(j,land);

pcm_grass(j,grassland) = f10_LUH2v2("y1995",j,grassland);
*** EOF pre.gms ***
