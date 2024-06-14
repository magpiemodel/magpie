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

*' A penalty is applied for the violation of bioenergy tree (betr) rules.
*' The penalty applies to the missing bioenergy tree land, i.e. where bioenergy tree land 
*' is lower than a certain fraction of total cropland.

  q30_betr_missing(j2)$(sum(ct, i30_betr_penalty(ct)) > 0) ..
    v30_betr_missing(j2) =g=
      vm_land(j2,"crop") * sum(ct, i30_betr_target(ct,j2)) - vm_area(j2,"betr","rainfed");

*' Rotational constraints prevent over-specialization. In this realization,
*' they are either implemented via rules (i30_implementation = 1) or 
*' a penalty payment if the constraints are violated (i30_implementation = 0).

*' Rule-based rotational constraints (i30_implementation = 1):

*' Minimum and maximum rotational constraints limit
*' the placing of crops. These rotational constraints reflect
*' crop rotations limiting the share a specific crop can cover of the total area
*' of a cluster.

  q30_rotation_max(j2,rotamax_red30)$(i30_implementation = 1) ..
    sum((rota_kcr30(rotamax_red30,kcr),w), vm_area(j2,kcr,w)) =l=
      sum((kcr,w),vm_area(j2,kcr,w)) * sum(ct,i30_rotation_rules(ct,rotamax_red30));

  q30_rotation_min(j2,rotamin_red30)$(i30_implementation = 1) ..
    sum((rota_kcr30(rotamin_red30,kcr),w), vm_area(j2,kcr,w)) =g=
      sum((kcr,w),vm_area(j2,kcr,w)) * sum(ct,i30_rotation_rules(ct,rotamin_red30));

* 'Penalty-based rotational constraints (i30_implementation = 0):

  q30_rotation_penalty(i2) ..
    vm_rotation_penalty(i2) =g=
      sum(cell(i2,j2),
        sum(rota30, v30_penalty(j2,rota30) * sum(ct, i30_rotation_incentives(ct,rota30)))
      + sum(rotamax_red30, v30_penalty_max_irrig(j2,rotamax_red30) 
      * sum(ct, i30_rotation_incentives(ct,rotamax_red30)))
      + v30_betr_missing(j2) * sum(ct, i30_betr_penalty(ct))
      );

*' The penalty applies to the areas which exceed a certain maximum
*' share of the land. Below this share, negative benefits are
*' avoided by defining the penalty to be positive.

  q30_rotation_max2(j2,rotamax_red30)$(i30_implementation = 0) ..
    v30_penalty(j2,rotamax_red30) =g=
      sum((rota_kcr30(rotamax_red30,kcr),w),vm_area(j2,kcr,w))
      - sum((kcr,w),vm_area(j2,kcr,w)) * sum(ct,i30_rotation_rules(ct,rotamax_red30));


*' Minimum constraints apply penalties when a certain mimimum
*' share of a group is not achieved. This is used to guarantee a minimum
*' crop group diversity withing cells.

  q30_rotation_min2(j2,rotamin_red30)$(i30_implementation = 0) ..
    v30_penalty(j2,rotamin_red30) =g=
      sum((kcr,w),vm_area(j2,kcr,w)) * sum(ct,i30_rotation_rules(ct,rotamin_red30))
      - sum((rota_kcr30(rotamin_red30,kcr),w), vm_area(j2,kcr,w));


*' The following maximum constraint avoids over-specialization in irrigated systems.
*' No minimum constraint is included for irrigated areas for computational
*' reasons. Minimum constraints just need to be met on total areas.

  q30_rotation_max_irrig(j2,rotamax_red30) ..
    v30_penalty_max_irrig(j2,rotamax_red30) =g=
      sum((rota_kcr30(rotamax_red30,kcr)), vm_area(j2,kcr,"irrigated"))
      - vm_AEI(j2) * sum(ct,i30_rotation_rules(ct,rotamax_red30));


*' The carbon stocks of the above ground carbon pools are calculated based on croparea and related carbon density.

  q30_carbon(j2,ag_pools) ..
    vm_carbon_stock_croparea(j2,ag_pools) =e=
      sum((kcr,w), vm_area(j2,kcr,w)) * sum(ct, fm_carbon_density(ct,j2,"crop",ag_pools));


*' The biodiversity value for cropland is calculated separately for annual and perennial crops:

  q30_bv_ann(j2,potnatveg) ..
    vm_bv(j2,"crop_ann",potnatveg) =e=
      sum((crop_ann30,w), vm_area(j2,crop_ann30,w)) * fm_bii_coeff("crop_ann",potnatveg) 
      * fm_luh2_side_layers(j2,potnatveg);

  q30_bv_per(j2,potnatveg) .. vm_bv(j2,"crop_per",potnatveg) =e=
    sum((crop_per30,w), vm_area(j2,crop_per30,w)) * fm_bii_coeff("crop_per",potnatveg) 
    * fm_luh2_side_layers(j2,potnatveg);


*' regional cropland area is calculated for the cropland growth constraint
 q30_crop_reg(i2) .. v30_crop_area(i2)
   =e=
   sum((cell(i2,j2), kcr, w), vm_area(j2,kcr,w));
