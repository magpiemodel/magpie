*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Fix Variables
vm_hvarea_secdforest.fx(j,ac_sub) = 0;
vm_hvarea_primforest.fx(j) = 0;
vm_land_fore.fx(j,"plant","ac0") = pm_land_start_ac(j,"plant","ac0");

** Provide lower bound manually to positive variables for avoiding inconsistencies
** in module realizations. These variables can't be fixed to a specific value.
** vm_cost_glo gets an upper bound because technically it can fluctuate between -Inf to Inf.
** vm_forestry_reduction gets a value fix because timber plantations are static from off realization.
vm_secdforest_reduction.lo(j,ac_sub) = 0;
vm_other_reduction.lo(j,ac_sub) = 0;
vm_primforest_reduction.lo(j) = 0;
vm_forestry_reduction.fx(j,"plant",ac_sub) = 0;
vm_cost_glo.up = Inf;
