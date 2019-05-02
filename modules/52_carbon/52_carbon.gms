*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Carbon
*'
*' @description The carbon module provides annual land-related CO2 emissions for the
*' [56_ghg_policy] module. The carbon module provides carbon density information
*' on cellular level to all land modules ([30_crop], [31_past], [32_forestry],
*' [34_urban] and [35_natveg]), and in return it gets the current carbon stock
*' levels from respective land pools. The module also accounts for changes in
*' terrestrial carbon stocks cause by climate change effects on biosphere [45_climate].   
*'
*'
*' @authors Benjamin Leon Bodirsky, Florian Humpenoeder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%carbon%" == "normal_dec17" $include "./modules/52_carbon/normal_dec17.gms"
$Ifi "%carbon%" == "off" $include "./modules/52_carbon/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
