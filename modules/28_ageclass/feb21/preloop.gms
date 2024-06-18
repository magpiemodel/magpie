*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Ben Poulter age class distribution
im_plantedclass_ac(j,ac)  = 0;
*im_plantedclass_ac(j,ac)  = sum(ac_poulter_to_ac(ac_poulter,ac),f28_forestageclasses(j,ac_poulter)$(not sameas(ac_poulter,"class15")));
im_plantedclass_ac(j,ac)  = sum(ac_poulter_to_ac(ac_poulter,ac),f28_forestageclasses(j,ac_poulter));

* As summing over makes double counting (two magpie age classes in one poulter class)
* We divide by 2
im_plantedclass_ac(j,ac)  = im_plantedclass_ac(j,ac) /2;
