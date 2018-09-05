*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' The nitrogen module calculates nitrogeneous emissions before technical
*' mitigation, including N2O, NOx, NH3, NO3- and N2.
*' The model receives information on nitrogen flows from [50_nr_soil_budget],
*' [55_awms], [18_residues], [59_som], and it provides the emissions to the
*' module [56_ghg_policy].
*' Emission estimates are largely based on the IPCC 2006 Guidelines for
*' National Greenhouse Gas Inventories (@ipcc_2006_2006.),
*' as described in (@bodirsky_current_2012.).
*'
*' @authors Benjamin Leon Bodirsky

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/51_nitrogen/ipcc2006_sep16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/51_nitrogen/ipcc2006_sep16/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/51_nitrogen/ipcc2006_sep16/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/51_nitrogen/ipcc2006_sep16/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/51_nitrogen/ipcc2006_sep16/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/51_nitrogen/ipcc2006_sep16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/51_nitrogen/ipcc2006_sep16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/51_nitrogen/ipcc2006_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################