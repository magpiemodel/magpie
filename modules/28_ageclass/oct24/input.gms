*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c28_ageclass_source  gami
* options: gfad (GFAD V1.1), gami (GAMI v2.1, default)

table f28_forestageclasses(j,ac_gfad) Forest area in 15 10-year age classes (Mha)
$ondelim
$ifthen "%c28_ageclass_source%" == "gami"
$include "./modules/28_ageclass/input/forestageclasses_gami.cs3"
$else
$include "./modules/28_ageclass/input/forestageclasses.cs3"
$endif
$offdelim
;
