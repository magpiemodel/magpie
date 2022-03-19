*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q44_cost_bv_loss .. sum(j2, vm_cost_bv_loss(j2))
 					=e=
 					v44_bv_slack * s44_price_slack;

q44_bv_glo2 .. v44_bv_glo$(sum(ct, m_year(ct)) > s44_start_year)
			  =g= 
			  v44_bv_glo.l + (s44_target - v44_bv_slack) * m_timestep_length;
*			  v44_bv_glo.l + (s44_target - v44_bv_slack) * m_timestep_length;

q44_bv_glo .. v44_bv_glo
			  =e= 
			  sum((j2,landcover44), v44_bv_weighted(j2,landcover44)) / sum((j2,land), vm_land(j2,land));

*' Biodiversity values of each land cover type are weighted by range-rarity (`f44_rr_layer`)
 q44_bv_weighted(j2,landcover44) .. v44_bv_weighted(j2,landcover44)
 					=e=
 					f44_rr_layer(j2) * sum(potnatveg, vm_bv(j2,landcover44,potnatveg));

*** EOF constraints.gms ***
