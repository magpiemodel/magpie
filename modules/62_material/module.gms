*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Material
*'
*' @description
*' The material module describes the demand for material usage
*' based on historical data. Material uage is derived from FAO's "other utils"
*' category, and includes for example the use of agricultural products
*' for cosmetics, chemical usage or textiles. In contrast to FAO's other util
*' category, the use for bioenergy (oils and ethanol) has been excluded
*' and is accounted for in the demand for bioenergy. Material demand in this
*' context can be considered as a subset of "other utils" category of FAO.
*' In addition, increasing material demand for bioplastic production can be
*' included by setting a target bioplastic demand.

*' @authors Benjamin Bodirsky, Debbora Leip

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%material%" == "exo_flexreg_apr16" $include "./modules/62_material/exo_flexreg_apr16/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
