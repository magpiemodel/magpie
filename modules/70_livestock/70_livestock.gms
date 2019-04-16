*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Livestock
*'
*' @description The livestock module calculates how much and what kind of
*' biomass is required as feed to produce livestock food commodities.
*'
*' For this purpose, the livestock module provides for every time-step regional
*' and product-specific feed baskets that determine type and magnitude of feed
*' needed to produce one unit of livestock commodities. Estimated pasture
*' feed demand is also relevant for the module [31_past] in order to derive
*' required pasture areas. The information flow between the livestock and the
*' pasture module is organized via interfaces `vm_dem_feed`, `vm_supply` and
*' `vm_prod_reg` via modules [16_demand] and [21_trade]. Feed demand estimates
*' are also required for the modules [53_methane] and [55_awms]. Additionally,
*' the livestock module provides production costs for livestock commodities.
*'
*' @authors Isabelle Weindl, Benjamin Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%livestock%" == "fbask_jan16" $include "./modules/70_livestock/fbask_jan16.gms"
*###################### R SECTION END (MODULETYPES) ############################
