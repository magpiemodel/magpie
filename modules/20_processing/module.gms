*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Processing

*' @description The processing module calculates the quantity of secondary products that
*' are generated through conversion of raw products (especially of primary plant agricultural commodities)
*' in order to meet the demand for those secondary products.

*' @authors Benjamin Leon Bodirsky, Amsalu Woldie Yalew


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%processing%" == "substitution_may21" $include "./modules/20_processing/substitution_may21/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
