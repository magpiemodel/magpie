*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The realization initialises land stocks reserved for land conservation across
*' grassland, forest and other land pools.
*' Land reserved for area-based conservation is derived from WDPA and is based on observed
*' land conservation trends. In 1995, the total area under land conservation (across all land
*' types) in the input data set is 864.31 Mha and, by 5-year time steps, increases to
*' 1662.02 Mha in 2020 (13.06 % of the total land area, excluding inland water bodies under
*' protection). After 2020 land conservation is held constant at 2020 values. The protected area
*' based on WDPA includes all areas under legal protection meeting the IUCN and CBD protected
*' area definitions (including IUCN categories Ia, Ib, III, IV, V, VI and 'not assigned' but
*' legally designated areas). Natural vegetation (natveg) and grassland ('past') within protected
*' areas cannot be converted to other land types. On top of the WDPA baseline protection, there are
*' future options to protect different conservation priority areas such as biodiversity hotspots (BH),
*' centers of plant diversity (CBD), Intact Forest Landscapes (IFL) and last of the wild (LW),
*' taken from @brooks_global_2006.
*' Future land conservation is distributed proportionally across natural vegetation types
*' (primary forest, secondary forest and other natural land).
*' @stop

*'
*' @limitations Land cover in the WDPA baseline data is estimated based on ESA-CCI
*' land-use/land-cover maps from 1995 to 2020, while land pools in MAgPIE are intialised
*' based on LUH2v2 data (forest areas are additionally harmonised with FAO data).
*' This leads to slight mismatches in some areas.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/22_land_conservation/area_based_apr22/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/22_land_conservation/area_based_apr22/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/22_land_conservation/area_based_apr22/input.gms"
$Ifi "%phase%" == "preloop" $include "./modules/22_land_conservation/area_based_apr22/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/22_land_conservation/area_based_apr22/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
