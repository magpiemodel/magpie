*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Area equipped for irrigation
*'
*' @description The area equipped for irrigation module constrains irrigated crop
*' production to those areas that are equipped with irrigation infrastructure and simulates
*' the evolution of areas equipped for irrigation. The module receives information about
*' the area actually irrigated from the [30_crop] module.
*'
*' @authors Anne Biewald, Markus Bonsch, Christoph Schmitz

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%area_equipped_for_irrigation%" == "endo_apr13" $include "./modules/41_area_equipped_for_irrigation/endo_apr13/realization.gms"
$Ifi "%area_equipped_for_irrigation%" == "static" $include "./modules/41_area_equipped_for_irrigation/static/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
