*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

pc52_carbon_stock(j,land,c_pools) = vm_carbon_stock.l(j,land,c_pools);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov52_carbon_stock_net_change(t,j,land,c_pools,"marginal") = v52_carbon_stock_net_change.m(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"marginal")              = vm_carbon_stock.m(j,land,c_pools);
 ov52_carbon_stock_expansion(t,j,land,c_pools,"marginal")  = v52_carbon_stock_expansion.m(j,land,c_pools);
 ov52_carbon_stock_reduction(t,j,land,c_pools,"marginal")  = v52_carbon_stock_reduction.m(j,land,c_pools);
 oq52_carbon_stock_expansion(t,j,land,c_pools,"marginal")  = q52_carbon_stock_expansion.m(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"marginal")  = q52_carbon_stock_reduction.m(j,land,c_pools);
 oq52_carbon_stock_net_change(t,j,land,c_pools,"marginal") = q52_carbon_stock_net_change.m(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"marginal")                   = q52_co2c_emis.m(j,emis_co2);
 ov52_carbon_stock_net_change(t,j,land,c_pools,"level")    = v52_carbon_stock_net_change.l(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"level")                 = vm_carbon_stock.l(j,land,c_pools);
 ov52_carbon_stock_expansion(t,j,land,c_pools,"level")     = v52_carbon_stock_expansion.l(j,land,c_pools);
 ov52_carbon_stock_reduction(t,j,land,c_pools,"level")     = v52_carbon_stock_reduction.l(j,land,c_pools);
 oq52_carbon_stock_expansion(t,j,land,c_pools,"level")     = q52_carbon_stock_expansion.l(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"level")     = q52_carbon_stock_reduction.l(j,land,c_pools);
 oq52_carbon_stock_net_change(t,j,land,c_pools,"level")    = q52_carbon_stock_net_change.l(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"level")                      = q52_co2c_emis.l(j,emis_co2);
 ov52_carbon_stock_net_change(t,j,land,c_pools,"upper")    = v52_carbon_stock_net_change.up(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"upper")                 = vm_carbon_stock.up(j,land,c_pools);
 ov52_carbon_stock_expansion(t,j,land,c_pools,"upper")     = v52_carbon_stock_expansion.up(j,land,c_pools);
 ov52_carbon_stock_reduction(t,j,land,c_pools,"upper")     = v52_carbon_stock_reduction.up(j,land,c_pools);
 oq52_carbon_stock_expansion(t,j,land,c_pools,"upper")     = q52_carbon_stock_expansion.up(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"upper")     = q52_carbon_stock_reduction.up(j,land,c_pools);
 oq52_carbon_stock_net_change(t,j,land,c_pools,"upper")    = q52_carbon_stock_net_change.up(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"upper")                      = q52_co2c_emis.up(j,emis_co2);
 ov52_carbon_stock_net_change(t,j,land,c_pools,"lower")    = v52_carbon_stock_net_change.lo(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"lower")                 = vm_carbon_stock.lo(j,land,c_pools);
 ov52_carbon_stock_expansion(t,j,land,c_pools,"lower")     = v52_carbon_stock_expansion.lo(j,land,c_pools);
 ov52_carbon_stock_reduction(t,j,land,c_pools,"lower")     = v52_carbon_stock_reduction.lo(j,land,c_pools);
 oq52_carbon_stock_expansion(t,j,land,c_pools,"lower")     = q52_carbon_stock_expansion.lo(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"lower")     = q52_carbon_stock_reduction.lo(j,land,c_pools);
 oq52_carbon_stock_net_change(t,j,land,c_pools,"lower")    = q52_carbon_stock_net_change.lo(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"lower")                      = q52_co2c_emis.lo(j,emis_co2);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
