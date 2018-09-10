*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description 
*' *Agricultural water demand*:
*'
*' Water demand for agriculture is endogenously calculated based on irrigated cropland
*' (`vm_area(j,kcr,"irrigated")`) and livestock production (`vm_prod(j,kli)`).
*'
*' *Non agricultural human water demand*:
*'
*' For industry, electricity and domestic demand, three scenarios are available on cluster
*' level from the model by @watergap_water_2003:
*'
*' SRES A2 (WATCH Project)
*'
*' SRES B1 (WATCH Project)
*'
*' SSP2 (ISI-MIP Project)
*'
*' The preprocessing script that extracts the @watergap_water_2003 data and converts it to MAgPIE input
*' can be found in:
*'
*' http://subversion/svn/magpie/tools/watdem_nonagr
*'
*' Due to the fact that MAgPIE only considers available blue water during the growing period
*' of the plants ([43_water_availability]), the fraction of this demand in the growing period
*' is determined in the preprocessing assuming constant demand over the whole year.
*' The matching of the WATERGAP scenarios to the MAgPIE scenarios can be found in the file
*' [scenario_config.csv] in the config subfolder of the main MAgPIE folder:
*'
*' *Environmental water demand*:
*'
*' Environmental water requirements can be specified separately using the switch
*' `s42_env_flow_scenario` in the input.gms. The following settings are available:
*'
*' * No additional environmental flows are considered.
*' * A certain fraction of available water (`s42_env_flow_fraction`) is reserved for
*' environmental purposes and consequently not available for agricultural activities
*' (in addition to `s42_reserved_fraction`).
*' * Environmental flow requirements (EFR) are calculated from LPJ1 inputs according
*' to an algorithm by  @smakhtin_water_2004 on cluster level. Due to the
*' fact that MAgPIE only considers available blue water during the growing period of
*' the plants [43_water_availability], EFR are also only calculated during this growing
*' period. These are reserved in addition to `s42_protected_fraction`.
*' In the case of the absence of an environmental flow protection policy, a base protection
*' can be specified: `s42_env_flow_base_fraction`. It defaults to 5 % of available water.
*'
*' @limitations The module uses a conveyance efficiency times management factor
*' for irrigation efficiency. Therefore, the management factor is double
*' accounted for because it is already considered in lpj airrig.
*' The module realization does not consider annual water balances, but only water balances
*' during the growing period of crops. This period differs between cells.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/42_water_demand/all_sectors_aug13/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/42_water_demand/all_sectors_aug13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/42_water_demand/all_sectors_aug13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/42_water_demand/all_sectors_aug13/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/42_water_demand/all_sectors_aug13/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/42_water_demand/all_sectors_aug13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/42_water_demand/all_sectors_aug13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/42_water_demand/all_sectors_aug13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
