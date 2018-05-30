*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Interest rate

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%interest_rate%" == "glo_jan16" $include "./modules/12_interest_rate/glo_jan16.gms"
$Ifi "%interest_rate%" == "reg_feb18" $include "./modules/12_interest_rate/reg_feb18.gms"
*###################### R SECTION END (MODULETYPES) ############################
