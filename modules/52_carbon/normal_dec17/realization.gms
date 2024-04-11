*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description  
*' This realization provides carbon density information on cellular level to all
*' land modules ([30_crop], [31_past], [32_forestry], [34_urban] and [35_natveg]). 
*' The realization 
*' also provides carbon density for different age-classes, based on a
*' chapman-richards volume growth model, to the land modules [32_forestry] and [35_natveg]
*' [@humpenoder_investigating_2014 and @braakhekke_modelling_2019].

*' @limitations

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/52_carbon/normal_dec17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/52_carbon/normal_dec17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/52_carbon/normal_dec17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/52_carbon/normal_dec17/equations.gms"
$Ifi "%phase%" == "start" $include "./modules/52_carbon/normal_dec17/start.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/52_carbon/normal_dec17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
