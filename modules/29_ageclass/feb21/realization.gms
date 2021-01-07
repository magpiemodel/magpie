*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  The age-class module calculates the distribution of secondary
*' forests and timber plantations based on Poulter dataset. This is used in
*' [32_forestry] and [35_natveg] for initialization of forest areas.

*' @limitations For the time being, this approach is not applied to livestock
*' products.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/29_ageclass/feb21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/29_ageclass/feb21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/29_ageclass/feb21/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/29_ageclass/feb21/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
