*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Animal waste management systems
*' @description
*' This module calculates the nutrient (NPK)) flows within animal waste management.
*' It receives information on feed from the module [70_livestock], and provides
*' information on recycled manure to [50_nr_soil_budget] and information on
*' greenhouse gas emissions to module [51_nitrogen].
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%awms%" == "ipcc2006_aug16" $include "./modules/55_awms/ipcc2006_aug16.gms"
$Ifi "%awms%" == "off" $include "./modules/55_awms/off.gms"
*###################### R SECTION END (MODULETYPES) ############################