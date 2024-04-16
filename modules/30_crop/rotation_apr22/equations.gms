*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Agricultural production is calculated by multiplying the area under
*' production with corresponding yields. Production from rainfed and irrigated
*' areas is summed up:

 q30_prod(j2,kcr) ..
  vm_prod(j2,kcr) =e= sum(w, vm_area(j2,kcr,w) * vm_yld(j2,kcr,w));


*' As additional constraints minimum and maximum rotational constraints limit
*' the placing of crops. On the one hand, these rotational constraints reflect
*' crop rotations limiting the share a specific crop can cover of the total area
*' of a cluster:

 q30_rotation_max(j2,rotamax_red30) ..
   sum((rotamax_kcr30(rotamax_red30,kcr),w), vm_area(j2,kcr,w)) =l=
     vm_land(j2,"crop") * sum(ct,i30_rotation_max_shr(ct,rotamax_red30));

 q30_rotation_min(j2,rotamin_red30) ..
    sum((rotamin_kcr30(rotamin_red30,kcr),w), vm_area(j2,kcr,w)) =g=
    vm_land(j2,"crop") * sum(ct,i30_rotation_min_shr(ct,rotamin_red30));


* The following maximum constraint avoids over-specialization in irrigated systems.
* No minimum constraint is included for irrigated areas for computational
* reasons. Minimum constraints just need to be met on total areas.

 q30_rotation_max_irrig(j2,rotamax_red30) ..
   sum((rotamax_kcr30(rotamax_red30,kcr)), vm_area(j2,kcr,"irrigated")) =l=
      vm_AEI(j2) * sum(ct,i30_rotation_max_shr(ct,rotamax_red30));


*' Bioenergy tree minimum share on cropland

q30_betr_shr(j2) ..
  sum(w, vm_area(j2,"betr",w)) =g=
  sum(ct, p30_betr_min_shr(ct,j2)) * vm_land(j2,"crop");


*' The carbon stocks of the above ground carbon pools are calculated based on croparea and related carbon density.

 q30_carbon(j2,ag_pools) ..
  vm_carbon_stock_croparea(j2,ag_pools) =e=
            sum((kcr,w), vm_area(j2,kcr,w)) * sum(ct, fm_carbon_density(ct,j2,"crop",ag_pools));


*' The biodiversity value for cropland is calculated separately for annual and perennial crops:

 q30_bv_ann(j2,potnatveg) ..
          vm_bv(j2,"crop_ann",potnatveg)
          =e=
          sum((crop_ann30,w), vm_area(j2,crop_ann30,w)) * fm_bii_coeff("crop_ann",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

 q30_bv_per(j2,potnatveg) .. vm_bv(j2,"crop_per",potnatveg)
          =e=
          sum((crop_per30,w), vm_area(j2,crop_per30,w)) * fm_bii_coeff("crop_per",potnatveg) * fm_luh2_side_layers(j2,potnatveg);
