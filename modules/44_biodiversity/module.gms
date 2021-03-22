*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @title Biodiversity
*'
*' @description In the biodiversity module biodiversity values are computed for each
*' land cover type. The calculations are based on the Biodiversity Intactness Index (BII).
*' BII values for each land cover type are multiplied by the respective land area and
*' are weighted by cluster-specific range-rarity. The module also allows to introduce costs
*' on the loss of the total biodiversity value.
*'
*' @authors Patrick v. Jeetze, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%biodiversity%" == "bv_btc_mar21" $include "./modules/44_biodiversity/bv_btc_mar21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
