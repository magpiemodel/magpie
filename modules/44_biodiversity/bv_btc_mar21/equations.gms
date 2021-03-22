*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @equations

*' The constraint `q44_cost_bv_loss(j2)` allows to introduce a price on biodiversity value loss. The total biodiversity value difference in each cluster is multiplied a cost factor.
 q44_cost_bv_loss(j2) .. vm_cost_bv_loss(j2)
 					=e=
 					v44_bv_loss(j2) * pc44_price_bv_loss;

*' The sum of biodiversity value loss in each cluster.
 q44_bv_loss(j2) .. v44_bv_loss(j2)
					=e=
					sum(landcover44, v44_diff_bv_landcover(j2,landcover44));

*' The difference of the biodiversity value for each land cover type.
 q44_diff_bv_landcover(j2,landcover44) .. v44_diff_bv_landcover(j2,landcover44)
 					=e=
 					pc44_bv_weighted(j2,landcover44) - v44_bv_weighted(j2,landcover44);

*' Biodiversity values of each land cover type are weighted by range-rarity (`f44_rr_layer`)
 q44_bv_weighted(j2,landcover44) .. v44_bv_weighted(j2,landcover44)
 					=e=
 					f44_rr_layer(j2) * sum(potnatveg, vm_bv(j2,landcover44,potnatveg));

*** EOF constraints.gms ***
