*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%factor_costs%" == "fixed_per_ton_mar18" $include "./modules/38_factor_costs/fixed_per_ton_mar18.gms"
$Ifi "%factor_costs%" == "fixed_per_ton_nov16" $include "./modules/38_factor_costs/fixed_per_ton_nov16.gms"
$Ifi "%factor_costs%" == "mixed_feb17" $include "./modules/38_factor_costs/mixed_feb17.gms"
$Ifi "%factor_costs%" == "sticky_feb18" $include "./modules/38_factor_costs/sticky_feb18.gms"
*###################### R SECTION END (MODULETYPES) ############################
