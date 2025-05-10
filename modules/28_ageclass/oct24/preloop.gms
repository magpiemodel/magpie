*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Two age-classes in `ac` are mapped to one age-class in `ac_gfad`. 
* Therefore, each age-class in `ac_gfad` is distributed equally to all belonging age-classes in `ac`.
im_forest_ageclass(j,ac)  = 0;
im_forest_ageclass(j,ac)  = sum(ac_gfad_to_ac(ac_gfad,ac),f28_forestageclasses(j,ac_gfad)) / 2;
* `class15` in GFAD1.1 includes forests that are 150 years or older, also including primary forest.
* Therefore, `class15` is mapped to the highest age-class `acx`.
im_forest_ageclass(j,"acx")  = f28_forestageclasses(j,"class15");
