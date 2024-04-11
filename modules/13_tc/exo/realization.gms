*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The exo realization stands for exogenous implementation of
*' technological change and land use intensification. The equations and structure 
*' are similar to the endo realization, with the difference that all variables are fixed.
*' The idea of exo realization is to prescribe intensification rates based 
*' on model runs with the endo realization. For instance, the endogenously derived 
*' intensification rates for a SSP2 baseline run can be used as exogenous input for 
*' a SSP2 policy run. The tau function in the magpie4 R package can be used to 
*' generate the file f13_tau_scenario.csv, which is region and time specific, based on 
*' an existing model run: tau(gdx,file="f13_tau_scenario.csv"). This file should then be
*' copied to the input folder (overwrite the existing dummy file f13_tau_scenario.csv).


*' @limitations TC is not allowed to adapt to the given demand requirements.This realization
*' might result in infeasibilities if the scenario setup diverges too much from the scenario
*' setup used to generate the file f13_tau_scenario.csv. If the pressure in the system is 
*' too high, the tau factors provided in the file f13_tau_scenario.csv might be insufficient
*' to solve the model. 

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/13_tc/exo/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/13_tc/exo/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/13_tc/exo/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/13_tc/exo/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/13_tc/exo/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/13_tc/exo/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
