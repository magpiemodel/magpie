*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Costs and CDR from afforestation are set to zero.
vm_cost_fore.fx(i) = 0;
vm_cdr_aff.fx(j) = 0;

*' All forestry land pools (`land32`) except for "old" are set to zero,
*' whereas "old" refers to the forestry plantations at the level of 1995.
v32_land.fx(j,"new") = 0;
v32_land.fx(j,"prot") = 0;
v32_land.fx(j,"grow") = 0;
v32_land.fx(j,"old") = pcm_land(j,"forestry");
*' @stop

* Aggregation of forestry land pools (`land32`).
vm_land.fx(j,"forestry") = sum(land32, v32_land.l(j,land32));

* The change of forestry land is also set to zero.
vm_landdiff_forestry.fx = 0;
fm_forestry_demand(t_all,i,kforestry) = 0;

* Set cellular forestry production to 0
vm_prod_cell_forestry.fx(j,kforestry) = 0;
*** EOF preloop.gms ***
