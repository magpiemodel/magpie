*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Processing

*' @description The processing module calculates the quantity of secondary products that
*' are generated through conversion of raw products (especially of primary plant agricultural commodities)
*' in order to meet the demand for those secondary products.

*' @authors Benjamin Leon Bodirsky, Amsalu Woldie Yalew


*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%processing%" == "coupleproducts_feb17" $include "./modules/20_processing/coupleproducts_feb17.gms"
$Ifi "%processing%" == "off" $include "./modules/20_processing/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
