*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description This realization describes the conversion process.
*' Secondary products are produced through some sort of mechanical or chemical processing
*' of primary crops. It is important to note here that by secondary products
*' we do refer only those for which information is available in Commodity Balance sheet of @FAOSTAT.
*' Among others, press cakes from oil production, molasses and bagasses
*' from sugar refinement and brans from cereal milling are important ones.
*' The use of these secondary products is given in the [16_demand] module.

*' @limitations Costs of processing depend on unit costs of processing 
*' collected, interpolated, extrapolated, and adjusted from a scant literature.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/20_processing/coupleproducts_feb17/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/20_processing/coupleproducts_feb17/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/20_processing/coupleproducts_feb17/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/20_processing/coupleproducts_feb17/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/20_processing/coupleproducts_feb17/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/20_processing/coupleproducts_feb17/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
