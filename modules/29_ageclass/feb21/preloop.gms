*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Ben Poulter age class distribution
i29_forestclass_ac(j,ac) = sum(ac_poulter_to_ac(ac_poulter,ac),f29_forestageclasses(j,ac_poulter));

* As summing over makes double counting (two magpie age classes in one poulter class)
* We divide by 2
i29_forestclass_ac(j,ac) = i29_forestclass_ac(j,ac)/2;

* Distribution for plantations to be used in forestry module
im_plantedclass_ac(j,ac) = i29_forestclass_ac(j,ac);

**changes subject to confirmation;
*classes 1, 2, 3 include plantation and are therefore excluded
*As disturbance history (fire) would affect the age structure
*We use the sahre from class 4 to be in class 1,2,3
*class 15 is primary forest and is therefore excluded
i29_forestclass_ac(j,ac_planted)$(i29_forestclass_ac(j,ac_planted) > f29_forestageclasses(j,"class4")/2) = f29_forestageclasses(j,"class4")/2;

* Distribute this area correctly
pm_poulter_dist(j,ac) = 0;
pm_poulter_dist(j,ac) = (i29_forestclass_ac(j,ac)/sum(ac2,i29_forestclass_ac(j,ac2)))$(sum(ac2,i29_forestclass_ac(j,ac2))>0);

display i29_forestclass_ac,pm_poulter_dist;
