*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov52_carbon_stock_change(t,j,land,c_pools,"marginal") = v52_carbon_stock_change.m(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"marginal")          = vm_carbon_stock.m(j,land,c_pools);
 ov52_carbon_stock_change(t,j,land,c_pools,"level")    = v52_carbon_stock_change.l(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"level")             = vm_carbon_stock.l(j,land,c_pools);
 ov52_carbon_stock_change(t,j,land,c_pools,"upper")    = v52_carbon_stock_change.up(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"upper")             = vm_carbon_stock.up(j,land,c_pools);
 ov52_carbon_stock_change(t,j,land,c_pools,"lower")    = v52_carbon_stock_change.lo(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"lower")             = vm_carbon_stock.lo(j,land,c_pools);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

