*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Age class

*' @description The age-class module calculates the distribution of secondary
*' forests and timber plantations based on Poulter dataset. This is used in
*' [32_forestry] and [35_natveg] for initialization of forest areas.

*' @authors Abhijeet Mishra, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%ageclass%" == "feb21" $include "./modules/28_ageclass/feb21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
