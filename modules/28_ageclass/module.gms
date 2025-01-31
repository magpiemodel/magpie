*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Age class

*' @description The age-class module provides forest area in age-classes 
*' to other modules. The interface `im_forest_ageclass` is used in
*' [35_natveg] for the initialization of secondary forest areas.

*' @authors Abhijeet Mishra, Florian Humpenöder

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%ageclass%" == "oct24" $include "./modules/28_ageclass/oct24/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
