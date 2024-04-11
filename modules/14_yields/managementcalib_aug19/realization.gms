*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The managementcalib_aug19 realization reads in the LPJmL data and
*' performs a number of calibrations. First, a bioenergy yield correction is performed.
*' As there is currently no robust information on bioenergy yields available in
*' [@FAOSTAT], it is assumed that the LPJmL yields for bioenergy correspond to the
*' yields achieved under the highest currently observed value of the $\tau$ factor
*' representing agricultural land-use intensity. Secondly, pasture yields are calculated
*' based on pasture demand to account for in- and extensification of managed grasslands.
*' Thirdly, irrigated yields are scaled to meet the irrigated-to-rainfed yield
*' ratio as provided by AQUASTAT [@fao_aquastat_2016].
*' Finally, crop yields are calibrated to FAO [@FAOSTAT] regional yield levels of the
*' initial time step. An additional feature of this realization is to allow crop yields
*' technological change from the precedent times step to spillover to pasture areas. This
*' realization also calculates the growth stocks in commercial plantations and natural
*' vegetation using LPJmL Carbon stocks.

*' @limitations The exogenous implementation of pasture intensification cannot
*' capture feedbacks between land scarcity and efforts to improve pasture
*' management. Moreover, the magnitude of spillover effects from technological change
*' in  the crop sector towards improvements in pasture management is very uncertain.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/managementcalib_aug19/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/managementcalib_aug19/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/managementcalib_aug19/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/managementcalib_aug19/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/managementcalib_aug19/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/managementcalib_aug19/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/managementcalib_aug19/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/managementcalib_aug19/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/managementcalib_aug19/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
