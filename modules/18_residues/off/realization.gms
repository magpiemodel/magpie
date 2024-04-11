*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description No representation of crop residues in the model. Residual biomass 
*' aboveground (`vm_res_biomass_ag`) and belowground (`vm_res_biomass_bg`) are set to 0, 
*' as well as biomass to be recycled (`vm_res_recycling`) or burned as agricultural 
*' residues (`vm_res_ag_burn`). Therefore, these types of crop residues are left unaccounted
*' for within any modules using these interface variable.

*' @limitations Should not be used if emission estimates are required or
*' climate policies are activated.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/18_residues/off/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/18_residues/off/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/18_residues/off/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/18_residues/off/preloop.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/18_residues/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
