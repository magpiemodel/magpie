*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q44_cost_bv_loss(j2)$(sum(ct, m_year(ct)) >= s44_start_year) .. vm_cost_bv_loss(j2)
 					=e=
 					v44_bii_weighted_ratio(j2) * 100 * s44_price_bii_weighted_loss;

*' diff BII weighted
 q44_bii_weighted_loss(j2) .. v44_bii_weighted_ratio(j2)
 					=e=
 					v44_bii_weighted.l(j2) - v44_bii_weighted(j2);

*' range-rarity weighted BII (`f44_rr_layer`)
 q44_bii_weighted(j2) .. v44_bii_weighted(j2)
 					=e=
 					f44_rr_layer(j2) * v44_bii(j2);

*' BII at cell level (0-1)
 q44_bii(j2) .. v44_bii(j2)
 					=e=
 					sum((landcover44,potnatveg), vm_bv(j2,landcover44,potnatveg)) / sum(land, vm_land(j2,land));

