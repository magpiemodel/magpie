*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pm_land_start(j,land) = f10_land("y1995",j,land);

pcm_land(j,land) = pm_land_start(j,land);
vm_land.l(j,land) = pcm_land(j,land);

pm_treecover_shr(j) = 0;
pm_treecover_shr(j)$(f10_land("y2015",j,"crop") > 1e-10) = 
 (f10_treecover(j)/f10_land("y2015",j,"crop"));

*** EOF pre.gms ***
