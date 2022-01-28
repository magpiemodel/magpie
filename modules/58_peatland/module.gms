*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Peatland
*'
*' @description The peatland module calculates GHG emissions from degrading/drained peatlands.
*'
*' @authors Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%peatland%" == "off" $include "./modules/58_peatland/off/realization.gms"
$Ifi "%peatland%" == "on" $include "./modules/58_peatland/on/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
