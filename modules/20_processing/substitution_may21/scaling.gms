*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_cost_processing.scale(i) = 1e5;
vm_processing_substitution_cost.scale(i) = 1e4;
*vm_secondary_overproduction.scale(i,kall,kpr) = 1e-3;
*q20_processing.scale(i,kpr,ksd) = 1e-3;
*q20_processing_aggregation_cereals.scale(i,kcereals20) = 1e-2;
*q20_processing_aggregation_cotton.scale(i) = 1e-3;
*q20_processing_aggregation_nocereals.scale(i,kpr) = 1e-2;
*q20_processing_substitution_brans.scale(i) = 1e-4;
*q20_processing_substitution_oils.scale(i) = 1e-3;
*q20_processing_substitution_protein.scale(i) = 1e-4;
*q20_processing_substitution_sugar.scale(i) = 1e-3;
