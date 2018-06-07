*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @equations

*' Annual CO2 emissions are calculated as difference in carbon stocks between the current 
*' and the previous time step, and divided by time step length (e.g. 5 or 10 years).
*'
*' Carbon stock expansion and reduction between the current and the previous time step.

 q52_carbon_stock_expansion(j2,land,c_pools) ..
        v52_carbon_stock_expansion(j2,land,c_pools) =g= 
			vm_carbon_stock(j2,land,c_pools) - pc52_carbon_stock(j2,land,c_pools);

 q52_carbon_stock_reduction(j2,land,c_pools) ..
        v52_carbon_stock_reduction(j2,land,c_pools) =g= 
			pc52_carbon_stock(j2,land,c_pools) - vm_carbon_stock(j2,land,c_pools);

*' Net change of carbon stocks (carbon stock expansion minus reduction).

 q52_carbon_stock_net_change(j2,land,c_pools) ..
                 v52_carbon_stock_net_change(j2,land,c_pools) =e=
                 v52_carbon_stock_expansion(j2,land,c_pools) - 
                 v52_carbon_stock_reduction(j2,land,c_pools);

*' Division of net carbon stock change by time step length to obtain annual carbon emissions.

 q52_co2c_emis(j2,emis_co2) ..
                 vm_btm_cell(j2,emis_co2,"co2_c") =e=
                 sum(emis_land(emis_co2,land,c_pools), 
                 -v52_carbon_stock_net_change(j2,land,c_pools)/m_timestep_length);

*** EOF constraints.gms ***
