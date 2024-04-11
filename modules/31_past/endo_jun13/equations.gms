*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Production of pasture biomass is restricted to pasture area which is
*' delivered as module output together with the resulting geographically
*' explicit production of pasture biomass. Cellular production is calculated by
*' multiplying pasture area `vm_land` with cellular rainfed pasture yields
*' `vm_yld` which are delivered by the module [14_yields]:

q31_prod(j2) ..
 vm_prod(j2,"pasture") =l= vm_land(j2,"past")
               * vm_yld(j2,"pasture","rainfed");

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools,stockType) ..
 vm_carbon_stock(j2,"past",ag_pools,stockType) =e= 
   m_carbon_stock(vm_land,fm_carbon_density,"past");

*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

q31_cost_prod_past(i2) ..
 vm_cost_prod_past(i2) =e= sum(cell(i2,j2), vm_prod(j2,"pasture")) * s31_fac_req_past;

*' For all following time steps, factor requriements `s31_fac_req_past` are set
*' to zero.

*' By estimating the different area of managed pasture and rangeland via the luh2 side layers, the biodiversity value for pastures and rangeland is calculated in following:
 q31_bv_manpast(j2,potnatveg) .. vm_bv(j2,"manpast",potnatveg)
          =e=
          vm_land(j2,"past") * fm_luh2_side_layers(j2,"manpast") * fm_bii_coeff("manpast",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

 q31_bv_rangeland(j2,potnatveg) .. vm_bv(j2,"rangeland",potnatveg)
          =e=
          vm_land(j2,"past") * fm_luh2_side_layers(j2,"rangeland") * fm_bii_coeff("rangeland",potnatveg) * fm_luh2_side_layers(j2,potnatveg);


*** EOF constraints.gms ***
