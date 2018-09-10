*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @equations

*' Change of carbon stocks is calculated as a difference between the current and
*' the previous time step.

 q52_carbon_stock_diff(j2,land,c_pools) ..
                 v52_carbon_stock_diff(j2,land,c_pools) =e=
                 pc52_carbon_stock(j2,land,c_pools) - vm_carbon_stock(j2,land,c_pools);

 q52_carbon_stock_reduction(j2,land,c_pools) ..
                 vm_carbon_stock_reduction(j2,land,c_pools) =g=
                 pc52_carbon_stock(j2,land,c_pools) - vm_carbon_stock(j2,land,c_pools);

*' Annual CO2 emissions are obtained by dividing `v52_carbon_stock_diff` by 
*' time step length (e.g. 5 or 10 years).

 q52_co2c_emis(j2,emis_co2) ..
                 vm_btm_cell(j2,emis_co2,"co2_c") =e=
                 sum(emis_land(emis_co2,land,c_pools),
                 v52_carbon_stock_diff(j2,land,c_pools)/m_timestep_length);

*** EOF constraints.gms ***
