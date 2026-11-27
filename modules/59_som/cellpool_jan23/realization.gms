*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description
*' The cellpool_jan23 realization is built on revised IPCC 2019 Guidelines for
*' National Greenhouse Gas Inventories (@calvo_buendia_ipcc_2019). It calculates the loss of
*' soil carbon due to cropping activities and management based on stock change factors,
*' compared to potential natural vegetation.
*' This approach also accounts for the temporal dimension of soil organic carbon change,
*' since it assumes a gradual step of 15% in the direction of the new equilibrium soil
*' organic carbon pool each year. Stock change factors tracks crop types as well as
*' management (e.g. irrigation) and input differences on cropland. Fallow land is
*' included in the cropland SOM target with a dedicated stock change factor.
*' Dedicated soil carbon management (SCM) can be switched on for a share of cropland, characterized 
*' by a higher input factor, which according to the IPCC guidelines reflects improved agronomic 
*' practices. Target shares are set exogenously and are phased in over time.
*' Two allocation modes are available via `s59_scm_mode`. In share mode (0), SCM is applied
*' on a given relative share of each cell's cropland area, including fallow land.
*' In area mode (1), the share target is translated into an absolute regional area target
*' (`i59_scm_target_area`), based either on previous timestep cropland area (dynamic) or
*' on a fixed reference year's cropland area (`s59_scm_reference_year`), and the
*' allocation of SCM to cells is endogenous (`v59_area_scm`, `v59_area_fallow_scm`).
*' In area mode, SCM on cropareas is restricted to annual crops, fallow land under SCM
*' is capped by the cell's fallow area, and the SCM area per cell is capped by
*' `s59_scm_max_share_per_cell`.

*' @limitations It is assumed that pastures and rangelandes as well as managed forests
*' do not change in soil carbon compared to the natural reference state. Moreover only
*' transitions from other land and primary forest to secondary forest between optimization
*' steps (due to natural regrowth and disturbance loss) are accounted for.


*' @authors Kristine Karstens, Benjamin Leon Bodirsky



*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/59_som/cellpool_jan23/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/59_som/cellpool_jan23/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/59_som/cellpool_jan23/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/59_som/cellpool_jan23/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/59_som/cellpool_jan23/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/59_som/cellpool_jan23/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/59_som/cellpool_jan23/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/59_som/cellpool_jan23/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
