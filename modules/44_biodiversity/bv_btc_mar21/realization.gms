*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realisation biodiversity values are computed for each
*' land cover type. The calculations are based on the Biodiversity Intactness Index (BII).
*' BII values for each land cover type are multiplied by the respective land area and
*' are weighted by cluster-specific range-rarity. This realisation also allows to introduce costs
*' on the loss of the total biodiversity value.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/44_biodiversity/bv_btc_mar21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/44_biodiversity/bv_btc_mar21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/44_biodiversity/bv_btc_mar21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/44_biodiversity/bv_btc_mar21/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/44_biodiversity/bv_btc_mar21/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/44_biodiversity/bv_btc_mar21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
