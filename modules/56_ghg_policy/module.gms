*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
*' The module collects carbon stock information in the interface `vm_carbon_stock` 
*' from all land modules ([30_crop], [31_past], [32_forestry], [34_urban] and [35_natveg]).
*' Please note that emissions that occur only once (e.g. CO2 emissions from deforestation) 
*' are handled differently than emissions that occur in every timestep 
*' (e.g. CH4 and N2O emissions from agricultural production).
*'
*' @authors Benjamin Bodirsky, Florian Humpenoeder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%ghg_policy%" == "price_aug22" $include "./modules/56_ghg_policy/price_aug22/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
