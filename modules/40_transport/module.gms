*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @title Transport
*'
*' @description The [40_transport] module simulates the intraregional 
*' transportation of agricultural products between producer site 
*' and the next city centre (market). It covers the transport of 
*' inputs such as fertilizers to the production site as well as 
*' the transport of products to the market. Calculations are based 
*' on cellular and global parameters and returns the corresponding 
*' cellular transport costs which are then used by the [11_costs] module. 
*'
*' @authors Jan Philipp Dietrich, Florian Humpenöder, Benjamin Bodirsky, Isabelle Weindl, Michael Krause.

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%transport%" == "gtap_nov12" $include "./modules/40_transport/gtap_nov12/realization.gms"
$Ifi "%transport%" == "off" $include "./modules/40_transport/off/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
