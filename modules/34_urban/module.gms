*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Urban Land
*'
*' @description The urban land module is one of the land modules in MAgPIE 
*' (see also the other land modules: [30_crop], [31_past], [32_forestry], [35_natveg]). 
*' It describes urban settlement areas and estimates their corresponding carbon content.
*'
*' @authors Jan Philipp Dietrich, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%urban%" == "static" $include "./modules/34_urban/static/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
