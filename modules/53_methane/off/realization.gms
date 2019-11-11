*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization is simple and accounts no methane emissions.
*' We acknowledge this is unrealistic. It is presented here for mere comparison and completeness.
*'
*' @limitations It is unrealistic to consider zero methane emissions and to ignore it from a model
*' such as MAgPIE which is meant to assess impacts of agricultural production on environment.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/53_methane/off/sets.gms"
$Ifi "%phase%" == "presolve" $include "./modules/53_methane/off/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
