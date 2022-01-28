*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The managementcalib_aug19 realization reads in the LPJmL data and
*' performs several corrections. First, a bioenergy yield correction is performed.
*' As there is currently no robust information on bioenergy yields available
*' in [@FAOSTAT], it is assumed that the LPJmL yields for bioenergy correspond
*' to the yields achieved under the highest currently observed value of the $\tau$
*' factor representing agricultural land-use intensity. Pasture yields are
*' calculated based on pasture demand to account for in- and extensification of
*' managed grasslands. Technological change spillover from crop yield increases
*' of the time step before is included additionally. Second, yields for all other
*' crops are corrected on the regional level by applying a calibration factor
*' that does not differentiate between crops. Pasture yields have their own
*' regional calibration factors. Applied calibration factors are derived via 
*' comparing cropland and pasture areas in the initial time step with values
*' reported by FAO [@FAOSTAT]. This realization also calculates the growing
*' stocks in commercial plantations and natural vegetation using LPJmL Carbon stocks.
*'
*' @limitations The exogenous implementation of pasture intensification cannot
*' capture feedbacks between land scarcity and efforts to improve pasture
*' management. And, the magnitude of spillover effects from technological change
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
