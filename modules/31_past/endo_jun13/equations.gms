*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Production of pasture biomass is restricted to pasture area which is
*' delivered as module output together with the resulting geographically
*' explicit production of pasture biomass. Cellular production is calculated by
*' multiplying pasture area `vm_land` with cellular rainfed pasture yields
*' `vm_yld` which are delivered by the module [14_yields]:

q31_prod(j2) ..
 vm_prod(j2,"pasture") =e= vm_land(j2,"past")
 						   * vm_yld(j2,"pasture","rainfed");

*' On the basis of the required pasture area, cellular carbon stocks are calculated:

q31_carbon(j2,c_pools) ..
 vm_carbon_stock(j2,"past",c_pools) =e=
         sum(ct, vm_land(j2,"past")*fm_carbon_density(ct,j2,"past",c_pools));

*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

q31_cost_prod_past(i2) ..
 vm_cost_prod(i2,"pasture") =e= vm_prod_reg(i2,"pasture")
 								* s31_fac_req_past;

*' For all following time steps, factor requriements `s31_fac_req_past` are set
*' to zero.

*** EOF constraints.gms ***
