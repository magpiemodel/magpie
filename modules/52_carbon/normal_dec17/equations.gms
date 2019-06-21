*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Change of carbon stocks is calculated as a difference between the current and
*' the previous time step.

 q52_carbon_stock_diff(j2,land,c_pools) ..
                 v52_carbon_stock_diff(j2,land,c_pools) =e=
                 pcm_carbon_stock(j2,land,c_pools) - vm_carbon_stock(j2,land,c_pools);

 q52_carbon_stock_reduction(j2,land,c_pools) ..
                 vm_carbon_stock_reduction(j2,land,c_pools) =g=
                 pcm_carbon_stock(j2,land,c_pools) - vm_carbon_stock(j2,land,c_pools);

*' Annual CO2 emissions are obtained by dividing `v52_carbon_stock_diff` by
*' time step length (e.g. 5 or 10 years).

 q52_co2c_emis(j2,emis_co2) ..
                 vm_btm_cell(j2,emis_co2,"co2_c") =e=
                 sum(emis_land(emis_co2,land,c_pools),
                 v52_carbon_stock_diff(j2,land,c_pools)/m_timestep_length);

*** EOF constraints.gms ***
