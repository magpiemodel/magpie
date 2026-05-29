*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Yields
*'
*' @description The yields module simulates the temporal development of crop
*' yields and pasture productivity. Spatially explicit information on pasture
*' productivity and crop yields under both rainfed and irrigated conditions is
*' provided by the global gridded crop model LPJmL (Lund-Potsdam-Jena with
*' managed Land) [@bondeau_lpjml_2007]. In the initial year of the simulation
*' period, crop yields and pasture productivity are calibrated at the regional
*' level to meet the observed cropland and pasture area as reported by FAO
*' [@FAOSTAT] or in the case of bioenergy crops Li et al. [@li_mapping_2020] [@li_global_2018]. 
*' For the simulation of the temporal development of agricultural
*' yields beyond biophysical processes, the module receives information about the agricultural land use
*' intensity represented by the $\tau$ factor coming from the module [13_tc].
*'
*' The module returns yields for all crops and for pasture, which is then used
*' by the modules [30_crop] and [31_past].
*'
*' @authors Jan Philipp Dietrich, Isabelle Weindl, Florian Humpenöder,
*' Anne Biewald, Kristine Karstens, Felicitas Beier


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%yields%" == "gsadapt_nov25" $include "./modules/14_yields/gsadapt_nov25/realization.gms"
$Ifi "%yields%" == "managementcalib_aug19" $include "./modules/14_yields/managementcalib_aug19/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
