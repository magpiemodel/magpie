*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
$Ifi "%demand%" == "sector_may15" $include "./modules/16_demand/sector_may15/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
