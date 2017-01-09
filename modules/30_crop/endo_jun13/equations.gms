*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 q30_cropland(j2)  ..
   sum((kcr,w), vm_area(j2,kcr,w)) =e= vm_land(j2,"crop","si0");

*Rotational constraints:
 q30_rotation_max(j2,crpmax30,w) ..
   sum((crp_kcr30(crpmax30,kcr)), vm_area(j2,kcr,w)) =l=
                         sum(kcr, vm_area(j2,kcr,w))*f30_rotation_max_shr(crpmax30);

 q30_rotation_min(j2,crpmin30,w) ..
   sum((crp_kcr30(crpmin30,kcr)), vm_area(j2,kcr,w)) =g=
                         sum(kcr, vm_area(j2,kcr,w))*f30_rotation_min_shr(crpmin30);

 q30_prod(j2,kcr) ..
  vm_prod(j2,kcr) =e= sum(w, vm_area(j2,kcr,w)*vm_yld(j2,kcr,w));

 q30_carbon(j2,c_pools) .. vm_carbon_stock(j2,"crop",c_pools) =e=
             sum(si, vm_land(j2,"crop",si)*sum(ct,fm_carbon_density(ct,j2,"crop",c_pools)));