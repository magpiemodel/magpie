*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_cost_agroforestry.fx(j) = 0;
vm_treecover_area.fx(j) = 0;
vm_treecover_carbon.fx(j,ag_pools,stockType) = 0;
vm_bv.fx(j,"crop_tree",potnatveg) = 0;
