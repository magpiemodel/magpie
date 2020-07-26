*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Costs and CDR from afforestation are set to zero.
vm_cost_fore.fx(i) = 0;
vm_cdr_aff.fx(j,ac) = 0;

*' All forestry land pools (aff, ndc, plant) are fixed to zero, 
*' except forestry plantations, which are fixed to the level of 1995.
v32_land.fx(j,type32,ac) = 0;
v32_land.fx(j,"plant","acx") = pcm_land(j,"forestry");
*' @stop

* Aggregation of forestry land pools (`land32`).
vm_land.fx(j,"forestry") = sum((type32,ac), v32_land.l(j,type32,ac));

* The change of forestry land is also set to zero. 
vm_landdiff_forestry.fx = 0;
vm_forestry_reduction.fx(j,type32,ac) = 0;


*** EOF preloop.gms ***
