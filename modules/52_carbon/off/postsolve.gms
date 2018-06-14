*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_carbon_stock(t,j,land,c_pools,"marginal")           = vm_carbon_stock.m(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"marginal") = vm_carbon_stock_reduction.m(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"level")              = vm_carbon_stock.l(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"level")    = vm_carbon_stock_reduction.l(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"upper")              = vm_carbon_stock.up(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"upper")    = vm_carbon_stock_reduction.up(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"lower")              = vm_carbon_stock.lo(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"lower")    = vm_carbon_stock_reduction.lo(j,land,c_pools);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

