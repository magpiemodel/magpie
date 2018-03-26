*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Optimization
*'
*' @description This module provides takes care of the model optimization of
*' the main model, allowing for switching between optimization procedures.
*'
*' @authors Jan Philipp Dietrich, Todd Munson

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%optimization%" == "lp_nlp_apr17" $include "./modules/80_optimization/lp_nlp_apr17.gms"
$Ifi "%optimization%" == "nlp_apr17" $include "./modules/80_optimization/nlp_apr17.gms"
*###################### R SECTION END (MODULETYPES) ############################
