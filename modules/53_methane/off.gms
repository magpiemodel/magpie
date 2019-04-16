*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
