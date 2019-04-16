*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
$Ifi "%transport%" == "gtap_nov12" $include "./modules/40_transport/gtap_nov12.gms"
$Ifi "%transport%" == "off" $include "./modules/40_transport/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
