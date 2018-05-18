*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The total land requirements for cropland are calculated as 
*' the sum of crop and water supply type specific land requirements:

 q30_cropland(j2)  ..
   sum((kcr,w), vm_area(j2,kcr,w)) =e= vm_land(j2,"crop");

*' We assume that crop production can only take place on suitable cropland area; 
*' we use the suitability index (SI) to exclude areas from cropland production that 
*' have low suitability, e.g. due to strong slopes (Krause et al 2013). 
*' The cultivated area therefore has to be greater than the "si0" cropland area:

 q30_suitability(j2)  ..
   vm_land(j2,"crop") =l= f30_land_si(j2,"si0");

*' As additional constraints minimum and maximum rotational constraints are active 
*' which are limiting the allowed distribution of crops. These rotational constraints 
*' are used to reflect on one hand crop rotations which limit the share of a specific 
*' crop which can be produced on average over time:
   
 q30_rotation_max(j2,crpmax30,w) ..
   sum((crp_kcr30(crpmax30,kcr)), 
   vm_area(j2,kcr,w)) =l= sum(kcr, vm_area(j2,kcr,w))
														 * f30_rotation_max_shr(crpmax30);

*' On the other hand it reflects boundary conditions such as minimum self sufficiency constraints: 
						 
 q30_rotation_min(j2,crpmin30,w) ..
   sum((crp_kcr30(crpmin30,kcr)), vm_area(j2,kcr,w)) =g= sum(kcr, vm_area(j2,kcr,w))
														 * f30_rotation_min_shr(crpmin30);


*' Agricultural production is also calculated straightforward by multiplying area 
*' under production with corresponding yields. Production from 
*' rainfed and irrigated areas is summed up to one cellular production:

 q30_prod(j2,kcr) ..
  vm_prod(j2,kcr) =e= sum(w, vm_area(j2,kcr,w)*vm_yld(j2,kcr,w));

*' Due to the high uncertainty in 2nd generation bioenergy production, irrigated 
*' production of bioenergy is deactivated (see presolve statements of crop realization).

*' The carbon content of the different carbon pools are calculated as a total for all cropland :
 q30_carbon(j2,c_pools) .. vm_carbon_stock(j2,"crop",c_pools) =e=  vm_land(j2,"crop") 
                                                                   * sum(ct,fm_carbon_density(ct,j2,"crop",c_pools));
