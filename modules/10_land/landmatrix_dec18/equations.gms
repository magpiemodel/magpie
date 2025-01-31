*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations


*' This equation defines the total amount of land to be constant over time. 

 q10_land_area(j2) ..
  sum(land, vm_land(j2,land)) =e=
  sum(land, pcm_land(j2,land));

*' The following two equations describe the land transition matrix.

 q10_transition_to(j2,land_to) ..
  sum(land_from, vm_lu_transitions(j2,land_from,land_to)) =e=
  vm_land(j2,land_to);

 q10_transition_from(j2,land_from) ..
  sum(land_to, vm_lu_transitions(j2,land_from,land_to)) =e=
  pcm_land(j2,land_from);

*' The following two equations calculate land expansion and land contraction based
*' on the above land transition matrix.

 q10_landexpansion(j2,land_to) ..
        vm_landexpansion(j2,land_to) =e=
        sum(land_from$(not sameas(land_from,land_to)),
        vm_lu_transitions(j2,land_from,land_to));

 q10_landreduction(j2,land_from) ..
        vm_landreduction(j2,land_from) =e=
        sum(land_to$(not sameas(land_from,land_to)),
        vm_lu_transitions(j2,land_from,land_to));

*' Small costs of 1 $ per ha on gross land-use change avoid unrealistic patterns in the land transition matrix

 q10_cost(j2) ..
        vm_cost_land_transition(j2) =e=
        sum(land, vm_landexpansion(j2,land) + vm_landreduction(j2,land)) * 1;

*' The gross changes in land are calculated based on land expansion, land
*' contraction and land changes from within the modules [35_natveg]
*' and [32_forestry]:

 q10_landdiff ..
    vm_landdiff =e= sum((j2,land), vm_landexpansion(j2,land)
                                 + vm_landreduction(j2,land))
                                 + vm_landdiff_natveg
                                 + vm_landdiff_forestry;
