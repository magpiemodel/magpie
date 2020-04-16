*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Fixing variables

v73_prod_heaven_timber.fx(j,kforestry) = 0;

vm_cost_timber.fx(i) = 0;
vm_hvarea_secdforest.fx(j,ac_sub) = 0;
v73_hvarea_other.fx(j,ac_sub) = 0;
vm_hvarea_primforest.fx(j) = 0;
vm_hvarea_forestry.fx(j,ac_sub) = 0;

vm_forestry_reduction.fx(j,"plant",ac_sub) = 0;
pm_demand_ext_original(t_ext,i,kforestry) = 0;
pm_demand_ext(t_ext,i,kforestry) = pm_demand_ext_original(t_ext,i,kforestry);
f21_trade_balanceflow(t_all,kforestry) = 0;
vm_prod.fx(j,kforestry) = 0;
