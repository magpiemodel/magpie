*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realisation, biodiversity stocks are computed for each land cover type by 
*' multiplication with Biodiversity Intactness Index (BII) coefficients from the PREDICTS database. 
*' The BII is relative indicator, wich measures the intactness of local species composition (abundance) compared to pristine conditions.
*' In addition, a range-rarity restoration prioritization layer is used in the optimization. 
*' This layer is a spatially explicit indicator of the regional relative range-rarity weighted species richness. 
*' It indicates the places holding more species and/or species of smaller range than other places in the same biome and continent. 
*' The net biodiversity stock loss (resp. gain) of any land-use change decision, weighted by the range-rarity layer, 
*' is taxed (resp. subsidized) within the optimization.
*' The implementation uses the methodology described in @leclere_biodiv_2018 and @leclere_bending_2020.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/44_biodiversity/bv_btc_mar21/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/44_biodiversity/bv_btc_mar21/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/44_biodiversity/bv_btc_mar21/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/44_biodiversity/bv_btc_mar21/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/44_biodiversity/bv_btc_mar21/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/44_biodiversity/bv_btc_mar21/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
