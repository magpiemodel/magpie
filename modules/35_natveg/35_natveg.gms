*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Natural Vegetation
*'
*' @description The natural vegetation (natveg) land module is one of the land modules in MAgPIE 
*' (see also the other land modules: [30_crop], [31_past], [32_forestry], [34_urban]). 
*' It calculates land and carbon stocks of natural vegetation, which consists of 
*' primary forest, secondary forest and other natural land. 
*' The module determines the availability of natural vegetation for land conversion.
*'
*' @authors Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%natveg%" == "dynamic_may18" $include "./modules/35_natveg/dynamic_may18.gms"
$Ifi "%natveg%" == "static" $include "./modules/35_natveg/static.gms"
*###################### R SECTION END (MODULETYPES) ############################
