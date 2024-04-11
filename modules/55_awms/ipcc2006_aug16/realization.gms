*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' Manure excretion is estimated using a mass balance approach and
*' based on NPK in feed and N in slaughtered animals (@bodirsky_current_2012.).
*' Animal waste management is largely based on the IPCC 2006 Guidelines for
*' National Greenhouse Gas Inventories (@ipcc_2006_2006.).

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
