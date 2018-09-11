*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Costs and CDR from afforestation are fixed to zero.
vm_cost_fore.fx(i) = 0;
vm_cdr_aff.fx(j,co2_forestry) = 0;

*' All forestry land pools except "old" are fixed to zero. "old" includes the forestry plantations at 1995 level. 
v32_land.fx(j,"new") = 0;
v32_land.fx(j,"prot") = 0;
v32_land.fx(j,"grow") = 0;
v32_land.fx(j,"old") = pcm_land(j,"forestry");

*' Aggregation of detailed land pools (`land32`).
vm_land.fx(j,"forestry") = sum(land32, v32_land.l(j,land32));

*' Difference in forestry land compared to previous timestep is also fixed to zero.
vm_landdiff_forestry.fx = 0;
*' @stop

*** EOF preloop.gms ***
