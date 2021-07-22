*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' In this realization, per hectare land conversion costs are separated into 
*' costs for expansion of cropland, pasture and forestry (establishment costs) and 
*' costs for clearing of primary forest, secondary forest and other natural land (clearing costs).
*' Global cost for cropland expansion are scaled with regional development state (0-1), 
*' which is used as a proxy for governance. By default, we assume 6000 USD/ha as minimum 
*' cost for cropland expansion and 25000 USD/ha as maximum (high-income countries).
*' For pasture (forestry) expansion we assume a global cost factor of 8000 (1000) USD/ha (static over time).
*' By default, clearing of natural vegetation is not priced. Plausible values range 
*' between 0-5 USD/tC (based on @kreidenweis_pasture_2018). 
*'
*' @limitations Data availability for land conversion costs is very limited.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/39_landconversion/devstate/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/39_landconversion/devstate/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/39_landconversion/devstate/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/39_landconversion/devstate/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/39_landconversion/devstate/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/39_landconversion/devstate/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/39_landconversion/devstate/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/39_landconversion/devstate/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
