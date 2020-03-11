*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description biomass_feb20 realization acts as a common tunnel for land related
*' decisions in forestry [32_forestry] and natveg [35_natveg] modules and corresponding
*' production of woody biomass realized.

*' @limitations WIP

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/73_timber/off/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/73_timber/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/73_timber/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
