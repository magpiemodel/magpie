*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In this realization the transport
*' of goods is assumed to be free of charge.
*' Correspondingly transportation costs are fixed to 0.
*'
*' @limitations No simulation of transportation (transportation free of charge).

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/40_transport/off/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/40_transport/off/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/40_transport/off/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
