*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Cost for biodiversity loss are obtained by multiplication of 
*' change in index points with price for biodiversity loss.
 q44_cost_bv_loss .. sum(j2, vm_cost_bv_loss(j2))
 					=e=
 					v44_bii_weighted_diff * s44_price_bii_loss * sum(ct, i44_fader(ct));

*' Difference in area- and range-rarity weighted biodiversity intactness index, converted to a range of [-100;100]
 q44_bii_weighted_diff .. v44_bii_weighted_diff
 					=e=
 					(v44_bii_weighted.l - v44_bii_weighted) * s44_index_conversion;

*' Area- and range-rarity weighted biodiversity intactness index [0-1]
 q44_bii_weighted .. v44_bii_weighted
 					=e=
 					sum((j2,landcover44,potnatveg), vm_bv(j2,landcover44,potnatveg) * f44_rr_layer(j2)) / sum((j2,land), vm_land(j2,land));

