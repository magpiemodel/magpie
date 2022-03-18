*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

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
$Ifi "%biodiversity%" == "bii_target" $include "./modules/44_biodiversity/bii_target/realization.gms"
$Ifi "%biodiversity%" == "bv_btc_mar21" $include "./modules/44_biodiversity/bv_btc_mar21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
