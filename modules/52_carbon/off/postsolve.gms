*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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

