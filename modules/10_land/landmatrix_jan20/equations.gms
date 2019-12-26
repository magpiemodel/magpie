*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The following three equations describe the general structure of the land transition matrix.
*' The first equation defines the total amount of land to be constant over time.

 q10_land(j2) ..
		sum(land, vm_land(j2,land)) =e= sum(land, pm_land_start(j2,land));

 q10_transition_to(j2,land_to10) ..
	sum(land_from10, v10_lu_transitions(j2,land_from10,land_to10)) =e=
	vm_land(j2,land_to10);

 q10_transition_from(j2,land_from10) ..
	sum(land_to10, v10_lu_transitions(j2,land_from10,land_to10)) =e=
	pcm_land(j2,land_from10);

*' The following two equations calculate land expansion and land contraction based
*' on the above land transition matrix.

 q10_landexpansion(j2,land_to10) ..
        vm_landexpansion(j2,land_to10) =e=
        sum(land_from10$(not sameas(land_from10,land_to10)),
        v10_lu_transitions(j2,land_from10,land_to10));

 q10_landreduction(j2,land_from10) ..
        v10_landreduction(j2,land_from10) =e=
        sum(land_to10$(not sameas(land_from10,land_to10)),
        v10_lu_transitions(j2,land_from10,land_to10));

*' Additionally the following two equations calculate the sources and targets
*' of all cropland related conversions.

q10_croplandreduction(j2,land_to10) ..
               vm_croplandreduction(j2,land_to10) =e=
               v10_lu_transitions(j2,"crop",land_to10);

q10_croplandexpansion(j2,land_from10) ..
               vm_croplandexpansion(j2,land_from10) =e=
               v10_lu_transitions(j2,land_from10,"crop");

*' Small costs of 1 $ per ha on gross land-use change avoid unrealistic patterns in the land transition matrix

 q10_cost(j2) ..
        vm_cost_land_transition(j2) =e=
        sum(land, vm_landexpansion(j2,land) + v10_landreduction(j2,land)) * 1;

*' The gross changes in land are calculated based on land expansion, land
*' contraction and land changes from within the modules [35_natveg]
*' and [32_forestry]:

 q10_landdiff ..
		vm_landdiff =e= sum((j2,land), vm_landexpansion(j2,land)
                                 + v10_landreduction(j2,land))
                                 + vm_landdiff_natveg
                                 + vm_landdiff_forestry;
