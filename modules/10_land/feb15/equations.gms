*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' This realization defines the total amount of land to be constant over time.

 q10_land(j2) ..
		sum(land, vm_land(j2,land)) =e= sum(land, pm_land_start(j2,land));

*' The following two equations calculate the land expansion and land contraction.

 q10_landexpansion(j2,land) ..
        vm_landexpansion(j2,land) =g= vm_land(j2,land)-pcm_land(j2,land);
 q10_landreduction(j2,land) ..
        v10_landreduction(j2,land) =g= pcm_land(j2,land)-vm_land(j2,land);

*' The gross changes in land are calculated based on land expansion, land
*' contraction and land changes from within the modules [35_natveg]
*' and [32_forestry]:

 q10_landdiff ..
		vm_landdiff =e= sum((j2,land), vm_landexpansion(j2,land)
                                 + v10_landreduction(j2,land))
                                 + vm_landdiff_natveg
                                 + vm_landdiff_forestry;
