*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q52_co2c(j2,emis_source_co2_land) ..
                 vm_btm_cell(j2,emis_source_co2_land,"co2_c")
                 =e=
                 sum(emis_co2_to_land(emis_source_co2_land,land,c_pools), pc52_carbon_stock(j2,land,c_pools)
                        - vm_carbon_stock(j2,land,c_pools))/m_timestep_length;

*** EOF constraints.gms ***
