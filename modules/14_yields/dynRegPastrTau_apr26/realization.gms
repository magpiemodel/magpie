*** |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The dynRegPastrTau_apr26 realization extends managementcalib_aug19
*' by replacing the global scalar spillover parameter for pasture yield increases
*' with a regional, time-varying input parameter `f14_yld_past_switch` (t_all x i).
*' All other yield calibration logic — bioenergy correction, pasture management
*' correction, FAO calibration, irrigated-to-rainfed ratio calibration, yield
*' calibration factors, and land degradation effects — is identical to
*' managementcalib_aug19.
*'
*' The parameter `f14_yld_past_switch(t_all,i)` scales the fraction of
*' crop-sector technological change (tau) that spills over to pasture yields,
*' and can vary across the MAgPIE world regions and across model
*' time steps from 1965 to 2150. A value of 0 implies no spillover; a value
*' of 1 implies full spillover equal to the crop-sector intensification rate.
*' The default input file populates all regions and time steps with values able to 
*' reproduce the behaviour of managementcalib_aug19 realization.

*' @limitations The exogenous implementation of pasture intensification cannot
*' capture feedbacks between land scarcity and efforts to improve pasture
*' management. Moreover, the magnitude of spillover effects from technological change
*' in the crop sector towards improvements in pasture management is very uncertain
*' and varies across regions and time periods.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/dynRegPastrTau_apr26/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/dynRegPastrTau_apr26/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/dynRegPastrTau_apr26/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/dynRegPastrTau_apr26/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/14_yields/dynRegPastrTau_apr26/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/dynRegPastrTau_apr26/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/dynRegPastrTau_apr26/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/dynRegPastrTau_apr26/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/dynRegPastrTau_apr26/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/dynRegPastrTau_apr26/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
