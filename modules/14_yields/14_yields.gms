*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Yields
*'
*' @description The yields module simulates agricultural and pasture yields based 
*' on yield data coming from LPJmL [@bondeau_lpjml_2007], which are calibrated in 
*' the initial time step, and based on land use intensities coming
*' from the module [13_tc].
*' The module returns yields for all crops and pasture,
*' which is then used by the modules [30_crop] and [31_past].
*' 
*' @authors Jan Philipp Dietrich, Florian Humpenöder, Anne Biewald, Isabelle Weindl



*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%yields%" == "biocorrect" $include "./modules/14_yields/biocorrect.gms"
$Ifi "%yields%" == "dynamic_aug18" $include "./modules/14_yields/dynamic_aug18.gms"
$Ifi "%yields%" == "staticpasture" $include "./modules/14_yields/staticpasture.gms"
*###################### R SECTION END (MODULETYPES) ############################
