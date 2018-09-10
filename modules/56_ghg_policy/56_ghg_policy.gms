*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Greenhouse gas policy
*'
*' @description The module 56_ghg_policy connects emissions to costs which then enter 
*' the objective function of MAgPIE. Connecting emissions with costs in a cost 
*' minimization model like MAgPIE creates an incentive to reduce emissions. 
*' This can be interpreted as an internalization of the external costs by pollution, 
*' e.g. by policies that deincentivize polluting activity. 
*' Technically, every ton of emission is multiplied with an emission price to 
*' determine emission costs. Emission sources can be excluded from pricing by switches 
*' defined in config/default.cfg.
*'
*' Please note that emissions that occur only once (e.g. CO2 emissions from deforestation) 
*' are handled differently than emissions that occur in every timestep 
*' (e.g. CH4 and N2O emissions from agricultural production).
*'
*' @authors Benjamin Bodirsky, Florian Humpenoeder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%ghg_policy%" == "price_sep16" $include "./modules/56_ghg_policy/price_sep16.gms"
*###################### R SECTION END (MODULETYPES) ############################
