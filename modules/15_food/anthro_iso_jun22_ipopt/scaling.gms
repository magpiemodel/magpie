*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

v15_income_pc_real_ppp_iso.scale(iso) = 1e5;
v15_kcal_intake_total_regr.scale(iso) = 1e3;
v15_kcal_regr_total.scale(iso) = 1e4;

*v15_objective.scale = 1e-4;
q15_budget.scale(iso) = 1e5;
v15_kcal_regr.scale(iso,kfo) = 1e4;
q15_food_demand.scale(i,kfo) = 1e6;
q15_regr_kcal.scale(iso) = 1e2;
q15_foodtree_kcal_animals.scale(iso,kfo_ap) = 1e4;
q15_foodtree_kcal_processed.scale(iso,kfo_pf) = 1e4;
q15_foodtree_kcal_vegetables.scale(iso) = 1e4;
q15_foodtree_kcal_staples.scale(iso,kfo_st) = 1e4;
q15_intake.scale(iso) = 1e3;
vm_emission_costs.scale(i) = 1e2;
