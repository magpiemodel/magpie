*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/biocorrect/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/biocorrect/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/biocorrect/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/biocorrect/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/biocorrect/preloop.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/biocorrect/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/biocorrect/nl_release.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/biocorrect/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
