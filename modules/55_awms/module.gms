*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Animal waste management systems
*' @description
*' This module calculates the nutrient (NPK) flows within animal waste management.
*' It receives information on feed from the module [70_livestock], and provides
*' information on recycled manure to [50_nr_soil_budget] and information on
*' greenhouse gas emissions to modules [51_nitrogen] and [53_methane].
*' @authors Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%awms%" == "ipcc2006_aug16" $include "./modules/55_awms/ipcc2006_aug16/realization.gms"
$Ifi "%awms%" == "off" $include "./modules/55_awms/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
