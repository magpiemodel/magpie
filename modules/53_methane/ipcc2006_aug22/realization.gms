*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This module realization calculates methane from different
*' agricultural sources based on the @ipcc_2006_2006.
*' Methane emission sources considered in the module are enteric fermentation,
*' animal waste management, and rice. Further, methane emissions from the burning
*' of agricultural residues is incorporated, with emissions factors taken
*' from the IPCC 2019 revision.

*' @limitations CH4 emissions from animal waste management may be
*' inconsistent with CH4 emissions from enteric fermentation.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/53_methane/ipcc2006_aug22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/53_methane/ipcc2006_aug22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/53_methane/ipcc2006_aug22/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/53_methane/ipcc2006_aug22/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/53_methane/ipcc2006_aug22/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/53_methane/ipcc2006_aug22/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
