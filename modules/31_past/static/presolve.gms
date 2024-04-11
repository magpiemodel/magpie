*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code Pasture areas are fixed to the initial spatially explicit patterns
*' defined in the module [10_land] by the land use input data set.

vm_land.fx(j,"past") = pcm_land(j,"past");

*' Correspondingly, also the above ground carbon stocks related to pasture areas are fixed.

vm_carbon_stock.fx(j,"past",ag_pools) =
          pcm_land(j,"past")*fm_carbon_density(t,j,"past",ag_pools);

*' Also the biodiversity value (BV) for pasture is fixed

vm_bv.fx(j,"manpast",potnatveg) =
          pcm_land(j,"past") * fm_luh2_side_layers(j,"manpast") * fm_bii_coeff("manpast",potnatveg) * fm_luh2_side_layers(j,potnatveg);

vm_bv.fx(j,"rangeland",potnatveg) =
          pcm_land(j,"past") * fm_luh2_side_layers(j,"rangeland") * fm_bii_coeff("rangeland",potnatveg) * fm_luh2_side_layers(j,potnatveg);

*' Regional costs associated with pasture management are set to zero.

vm_cost_prod_past.fx(i) = 0;

*' @stop
