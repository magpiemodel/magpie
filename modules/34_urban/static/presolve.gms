*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


vm_land.fx(j,"urban") = pcm_land(j,"urban");
vm_carbon_stock.fx(j,"urban",ag_pools,stockType) = 0;
*' Biodiveristy value (BV)
vm_bv.fx(j,"urban", potnatveg) = pcm_land(j,"urban") * fm_bii_coeff("urban",potnatveg) * fm_luh2_side_layers(j,potnatveg);

vm_cost_urban.fx(j) = 0;
