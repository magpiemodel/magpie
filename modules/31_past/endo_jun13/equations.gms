*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q31_prod(j2) .. vm_prod(j2,"pasture")
                =e=
                sum(si, vm_land(j2,"past",si))*vm_yld(j2,"pasture","rainfed");

 q31_carbon(j2,c_pools) .. vm_carbon_stock(j2,"past",c_pools)
                          =e=
                          sum((si,ct), vm_land(j2,"past",si)*fm_carbon_density(ct,j2,"past",c_pools));

*** EOF constraints.gms ***
