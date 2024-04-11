*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realisation, biodiversity stocks are computed for each land cover type by
*' multiplication with Biodiversity Intactness Index (BII) coefficients from the PREDICTS database.
*' The BII is a relative indicator, wich measures the intactness of local species assemblages (species richness)
*' compared to a reference state (space-for-time approach) (@purvis_chapter_2018).
*' In addition, a range-rarity restoration prioritization layer is used in the optimization.
*' This layer is a spatially explicit indicator of the regional relative range-rarity weighted species richness.
*' derived from the IUCN Red List of Threatened Species (@iucn_iucn_2020).
*' It indicates the global importance of a given cell for species conservation, typically of smaller range,
*' as compared to other cells.
*' Conceptually, the range-rarity weighted biodiversity stock is the product of
*' land cover area (Mha), corresponding BII coefficient [0-1] (unitless) and range-rarity layer [0-1] (unitless).
*' The net biodiversity stock loss (resp. gain) of any land-use change decision, weighted by the range-rarity layer,
*' is taxed (resp. subsidized) within the optimization.
*' The implementation uses the methodology described in @leclere_biodiv_2018 and @leclere_bending_2020.

*' @limitations The BII indicator has been proposed as a proxy for functional diversity, but here is weighted
*' by an aggegrated conservation priority (range-rarity) layer with no clear linkage to ecosystem functioning
*' outside the priority areas (including areas that stabilise the earth system such as the Amazonas basin or the
*' boreal forest). 'Biodiversity stocks' in this realisation are estimated at cluster level, but optimised at the
*' global scale without spatial reference (besides the range-rarity weight). They are therefore theoretically
*' interchangeable across biomes or other spatial units with different biophysical conditions.
*' Scenario design and results based on this realisation should be handled with special caution, in particular
*' when applied in policy contexts. It is strongly advised to complement a positive price on biodiversity loss
*' (resp. gain) in this realization with targeted protection measures ([35_natveg]).

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/44_biodiversity/bv_btc_mar21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/44_biodiversity/bv_btc_mar21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/44_biodiversity/bv_btc_mar21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/44_biodiversity/bv_btc_mar21/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/44_biodiversity/bv_btc_mar21/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/44_biodiversity/bv_btc_mar21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
