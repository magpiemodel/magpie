*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Land Conversion Costs

*' @description The land conversion cost module calculates costs for the conversion
*' from one land type to another (e.g. conversion from forest to cropland).
*' Expansion of agricultural land plays an important role for the overall model dynamics,
*' in particular in terms of CO2 emissions from land-use change.
*'
*' @authors Florian Humpenöder, Jan Philipp Dietrich, Ulrich Kreidenweis

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%landconversion%" == "global_static_aug18" $include "./modules/39_landconversion/global_static_aug18.gms"
*###################### R SECTION END (MODULETYPES) ############################
