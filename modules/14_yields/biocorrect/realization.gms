*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The biocorrect realization reads in the LPJmL data and performs
*' several corrections.
*' First, a bioenergy yield correction is performed. As there is currently no
*' robust information on bioenergy yields available in [@FAOSTAT], it is assumed
*' that the LPJmL yields for bioenergy correspond to the yields achieved under
*' the highest currently observed value of the $\tau$ factor representing
*' agricultural land use intensity. Bioenergy yields are downscaled
*' proportionally to the respective $\tau$ factor in the given region.
*' Second, yields for all other crops are corrected on the regional
*' level by applying a calibration factor that does not differentiate between
*' crops. Pasture yields have their own regional calibration factors. Applied
*' calibration factors are derived via comparing cropland and pasture areas in
*' the initial time step with values reported by FAO [@FAOSTAT].
*'
*' @limitations The magnitude of spillover effects from technological change in
*' the crop sector towards improvements in pasture management is very uncertain.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/biocorrect/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/biocorrect/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/biocorrect/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/biocorrect/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/biocorrect/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/biocorrect/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/biocorrect/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/biocorrect/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
