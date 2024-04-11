*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
$Ifi "%interest_rate%" == "select_apr20" $include "./modules/12_interest_rate/select_apr20/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
