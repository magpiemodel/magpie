*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

pcm_carbon_stock(j,land,c_pools) = vm_carbon_stock.l(j,land,c_pools);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_carbon_stock(t,j,land,c_pools,"marginal")   = vm_carbon_stock.m(j,land,c_pools);
 oq52_co2c(t,j,emis_source_co2_land,"marginal") = q52_co2c.m(j,emis_source_co2_land);
 ov_carbon_stock(t,j,land,c_pools,"level")      = vm_carbon_stock.l(j,land,c_pools);
 oq52_co2c(t,j,emis_source_co2_land,"level")    = q52_co2c.l(j,emis_source_co2_land);
 ov_carbon_stock(t,j,land,c_pools,"upper")      = vm_carbon_stock.up(j,land,c_pools);
 oq52_co2c(t,j,emis_source_co2_land,"upper")    = q52_co2c.up(j,emis_source_co2_land);
 ov_carbon_stock(t,j,land,c_pools,"lower")      = vm_carbon_stock.lo(j,land,c_pools);
 oq52_co2c(t,j,emis_source_co2_land,"lower")    = q52_co2c.lo(j,emis_source_co2_land);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
