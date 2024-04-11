*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Urban Land
*'
*' @description The urban land module is one of the land modules in MAgPIE
*' (see also the other land modules: [30_crop], [31_past], [32_forestry], [35_natveg]).
*' It describes urban settlement areas and estimates their corresponding carbon content and biodiversity values.
*'
*' @authors Jan Philipp Dietrich, Florian Humpenöder, David Meng-Chuen Chen, Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%urban%" == "exo_nov21" $include "./modules/34_urban/exo_nov21/realization.gms"
$Ifi "%urban%" == "static" $include "./modules/34_urban/static/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
