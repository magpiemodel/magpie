*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
$Ifi "%area_equipped_for_irrigation%" == "endo_apr13" $include "./modules/41_area_equipped_for_irrigation/endo_apr13.gms"
$Ifi "%area_equipped_for_irrigation%" == "static" $include "./modules/41_area_equipped_for_irrigation/static.gms"
*###################### R SECTION END (MODULETYPES) ############################
