*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_cost_cropland.fx(j) = 0;
vm_fallow.fx(j) = 0;
vm_bv.fx(j,"crop_fallow",potnatveg) = 0;
vm_bv.fx(j,"crop_tree",potnatveg) = 0;

*' Area potentially available for cropping
p29_avl_cropland(t,j) = f29_avl_cropland(j,"%c29_marginal_land%");
