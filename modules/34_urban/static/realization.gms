*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the static realization, urban land remains static over time
*' with the spatial distribution of 1995 from the LUH2 data
*' set [@hurtt2018luh2]. Carbon stocks are fixed to zero because
*' information on urban land carbon density is missing.

*' @limitations Urban land is static over time and
*' corresponding carbon stocks are assumed zero

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/34_urban/static/declarations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/34_urban/static/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/34_urban/static/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
