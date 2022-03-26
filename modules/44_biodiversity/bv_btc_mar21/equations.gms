*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The net biodiversity stock loss (resp. gain) of any land-use change decision in any cluster 
*' is taxed (resp. subsidized) within the optimization.
 q44_cost_bv_loss(j2) .. vm_cost_bv_loss(j2)
 					=e=
 					v44_bv_loss(j2) * sum(ct, p44_price_bv_loss(ct));

*' Sum over land cover types
 q44_bv_loss(j2) .. v44_bv_loss(j2)
					=e=
					sum(landcover44, v44_diff_bv_landcover(j2,landcover44));

*' Change in biodiversity stock for each land cover type compared to previous time step
 q44_diff_bv_landcover(j2,landcover44) .. v44_diff_bv_landcover(j2,landcover44)
 					=e=
 					pc44_bv_weighted(j2,landcover44) - v44_bv_weighted(j2,landcover44);

*' Biodiversity stock of each land cover type weighted by range-rarity restoration layer (`f44_rr_layer`)
 q44_bv_weighted(j2,landcover44) .. v44_bv_weighted(j2,landcover44)
 					=e=
 					f44_rr_layer(j2) * sum(potnatveg, vm_bv(j2,landcover44,potnatveg));

*** EOF constraints.gms ***
