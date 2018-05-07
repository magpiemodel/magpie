*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

pc52_carbon_stock(j,land,c_pools) = vm_carbon_stock.l(j,land,c_pools);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_carbon_stock(t,j,land,c_pools,"marginal") = vm_carbon_stock.m(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"marginal")      = q52_co2c_emis.m(j,emis_co2);
 ov_carbon_stock(t,j,land,c_pools,"level")    = vm_carbon_stock.l(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"level")         = q52_co2c_emis.l(j,emis_co2);
 ov_carbon_stock(t,j,land,c_pools,"upper")    = vm_carbon_stock.up(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"upper")         = q52_co2c_emis.up(j,emis_co2);
 ov_carbon_stock(t,j,land,c_pools,"lower")    = vm_carbon_stock.lo(j,land,c_pools);
 oq52_co2c_emis(t,j,emis_co2,"lower")         = q52_co2c_emis.lo(j,emis_co2);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
