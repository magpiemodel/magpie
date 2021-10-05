*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @title Labour productivity

*' @description This module provides a labour productivity factor (0-1), 
*' which reflects the efficiency of labour under changing environmental conditions (1 = no change).
*' The labour productivity factor is currently only considered in the sticky_labour_aug21 
*' realizations of the [38_factor_costs] module.

*' @authors Florian Humpenöder, Michael Windisch


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%labor_prod%" == "exo" $include "./modules/37_labor_prod/exo/realization.gms"
$Ifi "%labor_prod%" == "off" $include "./modules/37_labor_prod/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
