*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Urban Land
*'
*' @description The urban land module is one of the land modules in MAgPIE 
*' (see also the other land modules: [30_crop], [31_past], [32_forestry], [35_natveg]). 
*' It describes urban settlement areas and estimates their corresponding carbon content.
*'
*' @authors Jan Philipp Dietrich, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%urban%" == "static" $include "./modules/34_urban/static.gms"
*###################### R SECTION END (MODULETYPES) ############################
