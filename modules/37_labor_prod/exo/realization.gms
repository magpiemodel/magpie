*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization accounts for climate change impacts on 
*' labor productivity, based on ESM experiments from the LAMACLIMA project 
*' <https://climateanalytics.org/projects/lamaclima/>. 
*' Heat‐induced impacts on labor productivity have been calculated using the 
*' methodology described in @orlov_labor_2021.
*' Heat-induced impacts on labor productivity are available for two different metrics 
*' (HOTHAPS and ISO) and work intensity levels (300W and 400W).
*' The Hothaps function describes the relationship between workability and the 
*' wet bulb globe temperature (WBGT).
*' WBGT is a heat index that measures heat stress impacts of 
*' temperature, humidity, wind speed, and solar radiation.
*' The ISO standards describe the frequency and duration of rest breaks at work 
*' under different levels of heat stress.
*' Work intensity: 300W and 400W stand for the level of work intensity measured in 
*' Watts (W), at which the impacts are estimated. The higher work intensity, 
*' the stronger is the heat exposure. For instance, the impacts of heatstress 
*' on labor productivity under 300W are less than under 400W. 
*' In previous studies, the level of work intensity in agriculture is assumed to be 400W. 
*' However, work intensity differs by region due to different levels of mechanization. 
*' While 400W is plausible for manual work, mechanized work is less labor intensity. 
*'
*' @limitations Climate change impacts on labor productivity are currently only 
*'        available for RCP1.9 and RCP8.5.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/37_labor_prod/exo/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/37_labor_prod/exo/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/37_labor_prod/exo/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/37_labor_prod/exo/preloop.gms"
*######################## R SECTION END (PHASES) ###############################
