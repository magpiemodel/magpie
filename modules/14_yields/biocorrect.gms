*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description The biocorrect realization reads the LPJmL data and performs 
*' several corrections. 
*' First, a bioenergy yield correction is performed: as there is currently no
*' robust information on bioenergy yields available in FAO, it is assumed that 
*' the LPJmL yields for bioenergy correspond to the yields achieved under the 
*' highest currently observed land use intensification.
*' All other bioenergy yields are downscaled proportional to the land use intensity
*' in the given region. Yields for all other crops are calibrated on the regional level
*' by applying a calibration factor. 
*' The purpose of the yield calibration is to derive a regional yield calibration 
*' factor that is applied to all crops equally. Pasture yields have their own regional
*' calibration factors. The goal of this step is to obtain simulated pasture and cropland 
*' area that is consistent with FAO data on the regional level in 1995.
*'
*' @limitations There are currently no known limitations of this realization

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
