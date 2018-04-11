*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization transportation costs are calculated based on the assumption that transport
*' costs are proportional to the mass which has to be transported and the time which is required 
*' for the transport.
*' 
*' @limitations The information in distances between production sites and markets is static over time, 
*' meaning that infrastructure is assumed to be static over time. Furthermore, transportation costs 
*' for non-ruminant products are excluded because currently there is no proper spatial allocation 
*' process for these products implemented.
*'
*' The Transport costs in the cluster level are the mean of the transport costs in the cells belonging to that 
*' cluster. If the Transport costs are extremely high in some cells and clusters are particularly 
*' large in that area, the cluster would have high transport costs that does not represent reality in that area.
*' This behavior would be prevented by increasing the weight of the economic region in the clusterization in 
*' in data preparation, which will lead to more and smaller clusters in that economic region.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/40_transport/gtap_nov12/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/40_transport/gtap_nov12/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/40_transport/gtap_nov12/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/40_transport/gtap_nov12/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
