*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Timber
*'
*' @description This module handles the production of timber using plantations [32_forestry]
*' and natural vegetation [35_natveg]. Timber can be produced from both commercial plantations
*' and natural forests. The module feeds `vm_prod` at cluster level to [17_production] and
*' [21_trade] modules. This module also calculates the "real" harvested area in natural
*' forests i.e. `vm_hvarea_primforest`,`vm_hvarea_secdforest` and `v73_hvarea_other`.
*'
*' @authors Abhijeet Mishra, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%timber%" == "biomass_mar20" $include "./modules/73_timber/biomass_mar20/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
