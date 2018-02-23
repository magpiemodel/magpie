*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/55_awms/ipcc2006_aug16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/55_awms/ipcc2006_aug16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/55_awms/ipcc2006_aug16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/55_awms/ipcc2006_aug16/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/55_awms/ipcc2006_aug16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/55_awms/ipcc2006_aug16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/55_awms/ipcc2006_aug16/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/55_awms/ipcc2006_aug16/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/55_awms/ipcc2006_aug16/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/55_awms/ipcc2006_aug16/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
