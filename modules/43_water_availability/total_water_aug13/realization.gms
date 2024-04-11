*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' The calculation of available water as described below happens
*' in the MAgPIE preprocessing.
*' This realization only considers renewable water resources, i.e.
*' runoff generated from precipitation. All runoff is assumed to
*' enter rivers, neglecting groundwater recharge. Other water resources
*' such as fossil groundwater, discharge from melting glaciers or
*' desalination are also not considered. The calculation of available
*' water per grid cell is based on LPJmL (@bondeau_lpjml_2007) simulations. For
*' each river basin, total annual runoff in the basin constitutes the
*' amount of water available in one year. In order to account for the fact that
*' water can only be supplied to the plants during the growing period, the mean 
*' growing period over all crops based on LPJmL sowing and harvesting dates (@bondeau_lpjml_2007)
*' is calculated in MAgPIE. Some data has been excluded from the calculation:
*'
*' * Winter crops in the northern hemisphere (sowing date later than June 
*' 29th and harvest date later than December 31st) because we assume
*' that irrigation does not take place during winter time.
*'
*' * Data points with crop yields below 10% of the world average yield.
*' Such a low yield indicates that the site is not appropriate for this
*' specific crop and the LPJmL (@bondeau_lpjml_2007) growing period simulation
*' is likely to be distorted.
*'
*' Therefore, water available for irrigation in each basin only consists of the
*' total runoff occurring in the mean growing period in all basin cells
*' except for cells where water storage in terms of dams is present (taken
*' from @biemans_water_2011). In this case, total annual runoff is available.
*'
*' The distribution of basin runoff in the growing period to the individual
*' grid cells is done using LPJmL (@bondeau_lpjml_2007) discharge as a weight.
*'
*' There is an interface to the [42_water_demand] module. If exogenous
*' non-agricultural water demand exceeds available water the missing amount is available
*' from groundwater to avoid infeasibility.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/43_water_availability/total_water_aug13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/43_water_availability/total_water_aug13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/43_water_availability/total_water_aug13/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/43_water_availability/total_water_aug13/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/43_water_availability/total_water_aug13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/43_water_availability/total_water_aug13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/43_water_availability/total_water_aug13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
