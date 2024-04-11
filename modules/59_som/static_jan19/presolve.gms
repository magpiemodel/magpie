*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_nr_som.fx(j) = 0;
vm_nr_som_fertilizer.fx(j) = 0;

i59_nr_som_exogenous_per_ha(t,i) = 0;
$if "%c59_exo_scen%" == "constant" i59_nr_som_exogenous_per_ha(t,i)$(sum(cell(i,j),pcm_land(j,"crop")) > 0) = f59_som_exogenous(t,i,"constant")/sum(cell(i,j),pcm_land(j,"crop"));
$if "%c59_exo_scen%" == "fadeout_2050" i59_nr_som_exogenous_per_ha(t,i)$(sum(cell(i,j),pcm_land(j,"crop")) > 0) = f59_som_exogenous(t,i,"fadeout_2050")/sum(cell(i,j),pcm_land(j,"crop"));

vm_nr_som.fx(j) = sum(cell(i,j),i59_nr_som_exogenous_per_ha(t,i)*pcm_land(j,"crop"));
vm_nr_som_fertilizer.fx(j) = sum(cell(i,j),i59_nr_som_exogenous_per_ha(t,i)*pcm_land(j,"crop"));
