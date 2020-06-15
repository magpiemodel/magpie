*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Fix Variables
vm_hvarea_secdforest.fx(j,ac_sub) = 0;
vm_hvarea_primforest.fx(j) = 0;

** Provide lower bound manually to positive variables for avoiding inconsistencies
** in module realizations. These variables can't be fixed to a specific value.
** vm_cost_glo gets an upper bound because technically it can fluctuate between -Inf to Inf.
** vm_forestry_reduction gets a value fix because timber plantations are static from off realization.
vm_secdforest_reduction.lo(j,ac_sub) = 0;
vm_other_reduction.lo(j,ac_sub) = 0;
vm_primforest_reduction.lo(j) = 0;
vm_forestry_reduction.fx(j,"plant",ac_sub) = 0;
vm_cost_glo.up = Inf;

** Future demand relevant in current time step depending on rotation length
** In off realization, foresight for future timber demand is taken away from
** the model. This makes sure that no new plantations are added and we stick
** to the assumption that existing plantation area is well equipped to meet
** timber demand.
pm_demand_forestry_future(i,kforestry)    = 0 ;
