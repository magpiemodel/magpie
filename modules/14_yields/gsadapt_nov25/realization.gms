*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The gsadapt_nov25 realization reads in the LPJmL data 
*' accounts for growing period adaption to climate change and also
*' performs a number of calibrations. 
*' Crop yields are calibrated to FAO [@FAOSTAT] regional yield levels of the initial time step
*' and bioenergy crops (betr, begr) are calibrated to global data by Li et al. [@li_mapping_2020] [@li_global_2018].
*' Bioenergy yields are corrected using the $\tau$ factor
*' representing agricultural land-use intensity.
*' Pasture yields are calculated based on pasture demand to account for
*' intensification and extensification of managed grasslands.
*' Optionally, irrigated yields are scaled to meet the irrigated-to-rainfed yield
*' ratio as provided by AQUASTAT [@fao_aquastat_2016].
*' This realization also calculates harvestable growing stock (`im_growing_stock`) as
*' stem biomass (tDM/ha) by dividing aboveground biomass by the IPCC biomass expansion
*' factor (BEF). BEF is always > 1 and converts total aboveground biomass to stem-only biomass.

*' @limitations The exogenous implementation of pasture intensification cannot
*' capture feedbacks between land scarcity and efforts to improve pasture
*' management. Moreover, the magnitude of spillover effects from technological change
*' in the crop sector towards improvements in pasture management is very uncertain.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/gsadapt_nov25/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/gsadapt_nov25/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/gsadapt_nov25/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/gsadapt_nov25/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/14_yields/gsadapt_nov25/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/gsadapt_nov25/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/gsadapt_nov25/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/gsadapt_nov25/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/gsadapt_nov25/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/gsadapt_nov25/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
