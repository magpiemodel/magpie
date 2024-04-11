*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The net biodiversity stock change is priced.
 q44_cost_bv_loss(j2) .. vm_cost_bv_loss(j2)
          =e=
          v44_bv_loss(j2) * sum(ct, p44_price_bv_loss(ct));

*' Change in biodiversity stock compared to previous time step, divided by time step length.
 q44_bv_loss(j2) .. v44_bv_loss(j2)
          =e=
          (v44_bv_weighted.l(j2) - v44_bv_weighted(j2))/m_timestep_length;

*' Biodiversity stock weighted by range-rarity restoration prioritization layer (`f44_rr_layer`)
 q44_bv_weighted(j2) .. v44_bv_weighted(j2)
          =e=
          f44_rr_layer(j2) * sum((potnatveg,landcover44), vm_bv(j2,landcover44,potnatveg));

*** EOF constraints.gms ***
