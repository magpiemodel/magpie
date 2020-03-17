*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pcm_carbon_stock(j,land,c_pools) = vm_carbon_stock.l(j,land,c_pools);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov52_carbon_stock_diff(t,j,land,c_pools,"marginal")      = v52_carbon_stock_diff.m(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"marginal")             = vm_carbon_stock.m(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"marginal")   = vm_carbon_stock_reduction.m(j,land,c_pools);
 oq52_carbon_stock_diff(t,j,land,c_pools,"marginal")      = q52_carbon_stock_diff.m(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"marginal") = q52_carbon_stock_reduction.m(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"marginal")                  = q52_co2c_emis.m(j,emis_co2);
 ov52_carbon_stock_diff(t,j,land,c_pools,"level")         = v52_carbon_stock_diff.l(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"level")                = vm_carbon_stock.l(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"level")      = vm_carbon_stock_reduction.l(j,land,c_pools);
 oq52_carbon_stock_diff(t,j,land,c_pools,"level")         = q52_carbon_stock_diff.l(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"level")    = q52_carbon_stock_reduction.l(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"level")                     = q52_co2c_emis.l(j,emis_co2);
 ov52_carbon_stock_diff(t,j,land,c_pools,"upper")         = v52_carbon_stock_diff.up(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"upper")                = vm_carbon_stock.up(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"upper")      = vm_carbon_stock_reduction.up(j,land,c_pools);
 oq52_carbon_stock_diff(t,j,land,c_pools,"upper")         = q52_carbon_stock_diff.up(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"upper")    = q52_carbon_stock_reduction.up(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"upper")                     = q52_co2c_emis.up(j,emis_co2);
 ov52_carbon_stock_diff(t,j,land,c_pools,"lower")         = v52_carbon_stock_diff.lo(j,land,c_pools);
 ov_carbon_stock(t,j,land,c_pools,"lower")                = vm_carbon_stock.lo(j,land,c_pools);
 ov_carbon_stock_reduction(t,j,land,c_pools,"lower")      = vm_carbon_stock_reduction.lo(j,land,c_pools);
 oq52_carbon_stock_diff(t,j,land,c_pools,"lower")         = q52_carbon_stock_diff.lo(j,land,c_pools);
 oq52_carbon_stock_reduction(t,j,land,c_pools,"lower")    = q52_carbon_stock_reduction.lo(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"lower")                     = q52_co2c_emis.lo(j,emis_co2);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
