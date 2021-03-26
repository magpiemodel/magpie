*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @title Biodiversity
*'
*' @description The biodiversity module estimates how the changes in land pools
*' affect terrestrial biodiversity. It requires information about the land
*' area of the different land pools provided by all land modules ([30_crop], [31_past], [32_forestry],
*' [34_urban] and [35_natveg]), as well as module [10_land] about the potential natural vegetation.
*'
*'
*' @authors Patrick v. Jeetze, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%biodiversity%" == "bv_btc_mar21" $include "./modules/44_biodiversity/bv_btc_mar21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
