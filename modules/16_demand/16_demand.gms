*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Demand
*'
*' @description The demand module calculates the demand for all commodities that
*' has to be fulfilled by the model. In addition, it returns some other basic
*' information needed for demand calculations but also needed by other modules.
*' A description of food demand scenarios that enter the model can be found
*' in @bodirsky_global_2015-1, @bodirsky_n2o_2012 and @valin_fooddemand_2013.
*'
*' @authors Isabelle Weindl, Benjamin Bodirsky, Jan Philipp Dietrich.

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%demand%" == "sector_dec18_forestry" $include "./modules/16_demand/sector_dec18_forestry.gms"
$Ifi "%demand%" == "sector_may15" $include "./modules/16_demand/sector_may15.gms"
*###################### R SECTION END (MODULETYPES) ############################
