*** |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The gsadapt_dynRegPastrTau realization reads in the LPJmL data
*' accounts for growing period adaption to climate change and also performs a number 
*' of calibrations. (1) Crop yields are calibrated to FAO [@FAOSTAT] regional yield 
*' levels of the initial time step. (2) Bioenergy yields are corrected using the 
*' $\tau$ factor representing agricultural land-use intensity. (3) Pasture yields are 
*' calculated based on pasture demand to account for intensification and extensification 
*' of managed grasslands. Optionally, irrigated yields are scaled to meet the irrigated-
*' to-rainfed yield ratio as provided by AQUASTAT [@fao_aquastat_2016]. 
*'
*' In addition, technological change in the crop sector can spill over to pasture yields,
*' with the magnitude of the spillover determined by the regional, time-varying input 
*' parameter f14_yld_past_switch (t_all,i). A value of 0 implies no spillover, while a 
*' value of 1 implies full spillover equal to the crop-sector intensification rate.
*' Technological spillover from the crop sector to pasture yields is controlled by 
*' s14_past_spillover_mode. 
*'   * Mode 0 uses the static scalar s14_yld_past_switch
*'   * Mode 1 can use regional, time-varying parameter provided by 
*'            f14_yld_past_switch(t_all,i) (default input is static though)
*'  In both modes, 0 disables spillover and 1 applies the full crop-sector intensification rate.
*'
*' This realization also calculates harvestable growing stock (`im_growing_stock`) as
*' stem biomass (tDM/ha) by dividing aboveground biomass by the IPCC biomass expansion
*' factor (BEF). BEF is always > 1 and converts total aboveground biomass to stem-only biomass.
*'
*' @limitations The exogenous implementation of pasture intensification cannot
*' capture feedbacks between land scarcity and efforts to improve pasture
*' management. Moreover, the magnitude of spillover effects from technological change
*' in the crop sector towards improvements in pasture management is very uncertain
*' and may vary across regions and time periods.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/gsadapt_dynPastrTau_jul26/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
