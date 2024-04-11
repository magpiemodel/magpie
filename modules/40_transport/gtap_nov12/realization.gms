*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization transportation costs
*' are calculated based on the assumption that transport
*' costs are proportional to the mass which has to be
*' transported and the time which is required for the transport.
*'
*' @limitations The information in distances between
*' production sites and markets is static over time,
*' meaning that infrastructure is assumed to be static
*' over time.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/40_transport/gtap_nov12/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/40_transport/gtap_nov12/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/40_transport/gtap_nov12/equations.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/40_transport/gtap_nov12/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
