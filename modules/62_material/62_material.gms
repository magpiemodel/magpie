*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Material
*'
*' @description The material module describes the demand for material usage
*' based on historical data. Material uage is derived from FAO's "other utils"
*' category. This category when translated into MAgPIE world, provide bioenergy
*' and material demand. Material demand in this context can be considered as a
*' subset of "other utils" category of FAO.

*' @authors Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%material%" == "exo_flexreg_apr16" $include "./modules/62_material/exo_flexreg_apr16.gms"
*###################### R SECTION END (MODULETYPES) ############################
