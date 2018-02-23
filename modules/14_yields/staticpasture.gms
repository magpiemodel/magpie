*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/staticpasture/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/staticpasture/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/staticpasture/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/staticpasture/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/staticpasture/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/staticpasture/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/staticpasture/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/staticpasture/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/staticpasture/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
