*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Grassland production is estimated by multiplying grassland areas and yields.
*' Technological change is applied to managed pastures yields through 'vm_tau',
*' whereas rangeland yields are kept unaltered after the preloop calibration of
*' 'i31_grass_yields'.

q31_prod_pm(j2) ..
  vm_prod(j2,"pasture") =l= v31_grass_area(j2,"range") * sum(ct,i31_grass_yields(ct,j2,"range"))
                          + v31_grass_area(j2,"pastr") * sum(ct,i31_grass_yields(ct,j2,"pastr")) *
                          sum((cell(i2,j2), supreg(h2,i2)), vm_tau(h2, "pastr") / fm_pastr_tau_hist("y1995",h2));

*' The sum of managed pastures and rangelands areas equal the parent
*' land class pastures areas in 'vm_land'.

q31_pasture_areas(j2)..
  vm_land(j2,"past") =e= sum(grassland, v31_grass_area(j2,grassland));

*' To avoid unrealistic conversions between rangelands and managed pastures areas,
*' a cost is associated with the expansion of rangelands and managed pastures 'v31_cost_grass_expansion'
*' in comparison with areas in the previous time step 'pc31_grass'.

q31_expansion_cost(j2,grassland) ..
  v31_cost_grass_expansion(j2, grassland) =g=
                          (v31_grass_area(j2, grassland) - pc31_grass(j2,grassland)) * s31_cost_expansion;

*' Cost of production account for the cost of moving animals to grassland areas plus the costs of
*' expanding aras of production.

q31_cost_prod_past(i2) ..
  vm_cost_prod_past(i2) =e= sum(cell(i2,j2), vm_prod(j2,"pasture")) * s31_cost_grass_prod +
                                 sum((cell(i2,j2), grassland), v31_cost_grass_expansion(j2,grassland));

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools,stockType) ..
 vm_carbon_stock(j2,"past",ag_pools,stockType) =e= 
   m_carbon_stock(vm_land,fm_carbon_density,"past");

*' By estimating the different area of managed pasture and rangeland via the luh2 side layers, the biodiversity value for pastures and rangeland is calculated in following:
  q31_bv_manpast(j2,potnatveg) .. vm_bv(j2,"manpast",potnatveg)
            =e=
          vm_land(j2,"past") * fm_luh2_side_layers(j2,"manpast") * fm_bii_coeff("manpast",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

  q31_bv_rangeland(j2,potnatveg) .. vm_bv(j2,"rangeland",potnatveg)
            =e=
          vm_land(j2,"past") * fm_luh2_side_layers(j2,"rangeland") * fm_bii_coeff("rangeland",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

*** EOF constraints.gms ***
