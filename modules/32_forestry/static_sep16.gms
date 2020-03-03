*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The static realisation is very simple and does not include any equation 
*' because forestry land is assumed constant at the observed 1995 level throughout time. 

*' @limitations Forestry activities such as establishment or 
*' harvest of plantations for wood production are not modeled. 
*' Also afforestation for CDR is not included.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/32_forestry/static_sep16/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/32_forestry/static_sep16/declarations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/32_forestry/static_sep16/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/32_forestry/static_sep16/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/32_forestry/static_sep16/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
