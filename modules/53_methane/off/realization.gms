*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description No representation of methane emissions within the model. While unrealistic, this 
*' realization may be useful for comparisons and completeness. When used, this realization
*' sets all emissions from enteric fermentation, animal waste management, rice cultivation, and
*' agricultural residue burning to 0.

*' @limitations It is unrealistic to consider zero methane emissions and to ignore it from a model
*' such as MAgPIE which is meant to assess impacts of agricultural production on environment.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/53_methane/off/sets.gms"
$Ifi "%phase%" == "preloop" $include "./modules/53_methane/off/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
