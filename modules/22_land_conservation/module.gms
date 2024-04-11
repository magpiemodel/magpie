*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Land conservation
*'
*' @description The land conservation (land_conservation) module initialises
*' land under legal protection for all land types, and provides future
*' options for land conservation based on conservation priority areas.
*' Based on the land area of the different land-use types (`pcm_land`)
*' from the previous time step, this module also calculates restoration
*' requirements to fulfil land conservation targets. Both the information on
*' the protection of remaining land areas as well as information on restoration
*' is transferred to the other land modules via the interface `pm_land_conservation`.
*' @authors Patrick v. Jeetze

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%land_conservation%" == "area_based_apr22" $include "./modules/22_land_conservation/area_based_apr22/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
