*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Interest rate
*' The interest rate module describes interest rates and the annuity-due used in the model.
*' The data of interest rates is used as interest rates, a risk-accounting factor associated with investment activities (Wang et al 2016).
*' These two factors are required for inter-temporal calculations in the model such as shifting investment from one time step to another
*' or distribution one-time investments over several time steps.
*' An annuity-due is an annuity whose payments are made at the beginning of each period (Jordan et al22000).
*' The annuity due is then used in the modules (13_tc, 39_landconversion, 41_area_equipped_for_irrigation, and 57_maccs) to compute the present value of annual costs.

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%interest_rate%" == "glo_jan16" $include "./modules/12_interest_rate/glo_jan16.gms"
$Ifi "%interest_rate%" == "reg_feb18" $include "./modules/12_interest_rate/reg_feb18.gms"
*###################### R SECTION END (MODULETYPES) ############################
