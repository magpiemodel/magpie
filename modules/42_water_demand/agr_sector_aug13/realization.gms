*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*'
*' This realization models agricultural sector water demand endogenously, while other sectors are kept exogenous;
*' Various settings for environmental water demand described below.
*'
*' *Agricultural water demand*:
*'
*' Water demand for agriculture is endogenously calculated based
*' on irrigated cropland `vm_area(j,kcr,"irrigated")` and livestock production
*' `vm_prod(j2,kli)`.
*'
*' Irrigation water demand per area for each crop category and cluster
*' is provided by the LPJmL model. This parameter refers to the water that
*' has to be applied to the field, i.e. it includes losses due to evaporation on
*' the field, but does not include losses during the water transport from source
*' to field. Livestock water demand `ic42_wat_req_k(j,kli)` is derived from FAO
*' data.
*'
*'
*' *Irrigation efficiency*:
*'
*' Switches for different scenarios for irrigation efficiency can be chosen:
*'
*' * A global static value of irrigation efficiency that is defined as the
*'   global weighted average of water losses from source to field ("conveyance
*'   efficiency times management factor") from @PIK_report104_2007.
*'   Here, irrigated area from @siebert_FAO_2007 has been used as aggregation
*'   weight.
*'   Contraction of AEI happens if a depreciation rate is set in the switch `s41_AEI_depreciation`. 
*'
*' * A regression of country values of the "conveyance efficiency times
*'   management factor" from @PIK_report104_2007 on GDP.
*'
*' ![Irrigation efficiency evolution with GDP for the SSP2 scenario.
*'  ](irrigation_efficiency.png){ width=80% }
*'
*' *Non agricultural human water demand*:
*'
*' Water demand from all other sectors is treated exogenously. The scalar
*' `s42_reserved_fraction` determines how much water is reserved for non
*' agricultural purposes. Technically, it is assigned to industrial use, while
*' demand for other non-agricultural sectors is set to 0. The default value is
*' 0.5.
*'
*' *Environmental water demand*
*'
*' Environmental water requirements can be specified separately using the switch
*' `s42_env_flow_scenario`. The following settings are available:
*'
*' * No additional environmental flows are considered.
*' * A certain fraction of available water `s42_env_flow_fraction` is reserved
*'   for environmental purposes and consequently not available for agricultural
*'   activities (in addition to `s42_reserved_fraction`).
*' * Environmental flow requirements (EFR) are calculated from LPJmL inputs
*'   according to an algorithm by  @smakhtin_water_2004 on cluster level. Due to
*'   the fact that MAgPIE only considers available blue water during the growing
*'   period of the plants ([43_water_availability]), EFR are also only
*'   calculated during this growing period. They are reserved in addition to
*'   `s42_protected_fraction`. In the case of the absence of an environmental
*'   flow protection (EFP) policy, a base protection can be specified:
*'   `s42_env_flow_base_fraction`. Its default value is 5 % of available water.
*'
*' Whether a potential EFP policy takes effect is determined by the parameter
*' `f42_env_flow_policy`.
*' The speed of transitioning to full environmental flow protection is determined
*' by specifying the start (`s42_efp_startyear`) and target (`s42_efp_targetyear`) year.
*'
*' @limitations The module uses the "conveyance efficiency times management
*' factor" for irrigation efficiency. Therefore, the management factor is
*' accounted twice, since it is already considered in LPJmL water quantity used
*' for irrigation (`airrig`: annual irrigation). Furthermore, the module
*' realization does not consider annual water balances but only water balances
*' during the growing period of crops. This period differs between cells.
*'

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/42_water_demand/agr_sector_aug13/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/42_water_demand/agr_sector_aug13/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/42_water_demand/agr_sector_aug13/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/42_water_demand/agr_sector_aug13/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/42_water_demand/agr_sector_aug13/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/42_water_demand/agr_sector_aug13/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/42_water_demand/agr_sector_aug13/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/42_water_demand/agr_sector_aug13/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
