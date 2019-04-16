*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @description In the static realization, urban land remains static over time
*' with the spatial distribution of 1995 from the LUH2 data
*' set [@hurtt_harmonization_inprep]. Carbon stocks are fixed to zero because
*' information on urban land carbon density is missing.

*' @limitations Urban land is static over time and
*' corresponding carbon stocks are assumed zero

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "presolve" $include "./modules/34_urban/static/presolve.gms"
*######################## R SECTION END (PHASES) ###############################
