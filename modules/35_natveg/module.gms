*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Natural Vegetation
*'
*' @description The natural vegetation (natveg) land module is one of the land modules in MAgPIE
*' (see also the other land modules: [30_crop], [31_past], [32_forestry], [34_urban]).
*' It calculates land and carbon stocks, as well as the biodiversity value, of natural vegetation,
*' which consists of primary forest, secondary forest and other natural land.
*' The module considers land conservation and determines the availability of natural vegetation
*' for land conversion.
*'
*' @authors Florian Humpenöder, Abhijeet Mishra, Patrick v. Jeetze

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%natveg%" == "pot_forest_may24" $include "./modules/35_natveg/pot_forest_may24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
