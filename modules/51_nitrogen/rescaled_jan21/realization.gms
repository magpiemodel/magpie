*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' The nitrogen module calculates nitrogeneous emissions before technical
*' mitigation, including N2O, NOx, NH3, NO3- and N2.
*' The model receives information on nitrogen flows from [50_nr_soil_budget],
*' [55_awms], [18_residues], [59_som], and it provides the emissions to the
*' module [56_ghg_policy].
*' Emissions factors estimates are largely based on the IPCC 2006 Guidelines for
*' National Greenhouse Gas Inventories (@ipcc_2006_2006.),
*' as described in (@bodirsky_current_2012.).
*'
*' @authors Benjamin Leon Bodirsky

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/51_nitrogen/rescaled_jan21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/51_nitrogen/rescaled_jan21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/51_nitrogen/rescaled_jan21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/51_nitrogen/rescaled_jan21/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/51_nitrogen/rescaled_jan21/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/51_nitrogen/rescaled_jan21/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/51_nitrogen/rescaled_jan21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
