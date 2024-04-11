*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*'
*' This realization models agricultural sector water withdrawals endogenously,
*' as described in the first realization.
*' Manufacturing, electricity and domestic demand are explicitly accounted for in various scenarios;
*' Various settings (same as in previous realization) for environmental water demand described below.
*'
*' *Agricultural water demand*:
*'
*' Water demand for agriculture is endogenously calculated based on irrigated
*' cropland `vm_area(j,kcr,"irrigated")` and livestock production
*' `vm_prod(j,kli)`.
*'
*' *Non agricultural human water withdrawals*:
*'
*' For manufacturing, electricity and domestic withdrawals, three scenarios of the
*' WATERGAP model provided by @wada_modeling_2016 are used:
*'
*' * SSP1
*' * SSP2
*' * SSP3
*'
*' Due to the fact that MAgPIE only considers available blue water during the
*' growing period of the plants ([43_water_availability]), the fraction of this
*' demand in the growing period is determined in the preprocessing assuming
*' constant demand over the whole year. The matching of the WATERGAP scenarios
*' to the MAgPIE scenarios can be found in the file `scenario_config.csv` in the
*' config folder of model.
*'
*' *Environmental water demand*:
*'
*' Environmental water requirements can be specified separately using the switch
*' `s42_env_flow_scenario`. The following settings are available:
*'
*' * No additional environmental flows are considered.
*' * A certain fraction of available water `s42_env_flow_fraction` is reserved
*'   for environmental purposes and consequently not available for agricultural
*'   activities (in addition to `s42_reserved_fraction`).
*' * Environmental flow requirements (EFR) are calculated from LPJmL inputs
*'   according to an algorithm by @smakhtin_water_2004 on cluster level. Due to
*'   the fact that MAgPIE only considers available blue water during the growing
*'   period of the plants [43_water_availability], EFR are also only calculated
*'   during this growing period. These are reserved in addition to
*'   `s42_protected_fraction`. In the case of the absence of an environmental
*'   flow protection policy, a base protection can be specified:
*'   `s42_env_flow_base_fraction`. It defaults to 5 % of available water.
*'
*' The speed of transitioning to full environmental flow protection is determined
*' by specifying the start (`s42_efp_startyear`) and target (`s42_efp_targetyear`) year.
*'
*' @limitations The module uses the "conveyance efficiency times management
*' factor" for irrigation efficiency. Therefore, the management factor is
*' accounted twice, since it is already considered in LPJmL water quantity used
*' for irrigation (`airrig`: annual irrigation). Furthermore, the module
*' realization does not consider annual water balances but only water balances
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
