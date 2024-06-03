*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realisation, the Biodiversity Intactness Index (BII) is 
*' calculated separately for each biome type of each biogeographic realm, which results in 71 different spatial units (@olson_biome_2001).
*' The BII is a relative indicator, wich measures the intactness of local species assemblages (species richness)
*' compared to a reference state (space-for-time approach) (@purvis_chapter_2018).
*' The implementation uses the BII coefficients described in @leclere_biodiv_2018 and @leclere_bending_2020.
*' The realisation allows to set a lower bound for the BII in the future, based on an annual growth rate.

*' @limitations 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/44_biodiversity/bii_target_apr24/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/44_biodiversity/bii_target_apr24/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/44_biodiversity/bii_target_apr24/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/44_biodiversity/bii_target_apr24/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/44_biodiversity/bii_target_apr24/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/44_biodiversity/bii_target_apr24/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/44_biodiversity/bii_target_apr24/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
