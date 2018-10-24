*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Interest rate

*' @description Interest rates are used in MAgPIE as a risk-accounting 
*' factor associated with investment activities [@wang_taking_2016].
*' Interest rates are required for inter-temporal calculations in the model
*' such as shifting investment from one time step to another or distribution of
*' one-time investments over several time steps (e.g. in the modules 
*' [13_tc], [39_landconversion] and [41_area_equipped_for_irrigation]).
*'
*' @authors Xiaoxi Wang

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%interest_rate%" == "glo_jan16" $include "./modules/12_interest_rate/glo_jan16.gms"
$Ifi "%interest_rate%" == "reg_feb18" $include "./modules/12_interest_rate/reg_feb18.gms"
*###################### R SECTION END (MODULETYPES) ############################
