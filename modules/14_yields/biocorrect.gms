*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The biocorrect realization reads in the LPJmL data and performs 
*' several corrections. 
*' First, a bioenergy yield correction is performed. As there is currently no
*' robust information on bioenergy yields available in [@FAOSTAT], it is assumed 
*' that the LPJmL yields for bioenergy correspond to the yields achieved under 
*' the highest currently observed value of the $\tau$ factor representing 
*' agricultural land use intensity.
*' 
*' Bioenergy yields are downscaled proportionally to the respective $\tau$ factor
*' in the given region. Yields for all other crops are corrected on the regional 
*' level by applying a calibration factor that does not differentiate between 
*' crops. Pasture yields have their own regional calibration factors. The goal 
*' of this correction is to improve the consistency of simulated pasture and
*' cropland area with data from [@FAOSTAT] on the regional level in the initial 
*' time step.
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
