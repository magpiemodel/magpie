*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Land Conversion Costs

*' @description The land conversion cost module calculates costs for the conversion
*' from one land type to another (e.g. conversion from forest to cropland).
*' Land conversion plays an important role for the overall model dynamics,
*' in particular in terms of CO2 emissions from land-use change.
*' Expansion of agricultural land is one of the major options in the model to increase 
*' agricultural production, besides yield increases ([13_tc], [14_yields]) and trade ([21_trade]).
*' 
*'
*' @authors Florian Humpenöder, Jan Philipp Dietrich, Ulrich Kreidenweis

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%landconversion%" == "calib" $include "./modules/39_landconversion/calib/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
