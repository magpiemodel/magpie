*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod_crop(t,i,factors,"marginal")   = vm_cost_prod_crop.m(i,factors);
 oq38_cost_prod_crop_labor(t,i,"marginal")   = q38_cost_prod_crop_labor.m(i);
 oq38_cost_prod_crop_capital(t,i,"marginal") = q38_cost_prod_crop_capital.m(i);
 ov_cost_prod_crop(t,i,factors,"level")      = vm_cost_prod_crop.l(i,factors);
 oq38_cost_prod_crop_labor(t,i,"level")      = q38_cost_prod_crop_labor.l(i);
 oq38_cost_prod_crop_capital(t,i,"level")    = q38_cost_prod_crop_capital.l(i);
 ov_cost_prod_crop(t,i,factors,"upper")      = vm_cost_prod_crop.up(i,factors);
 oq38_cost_prod_crop_labor(t,i,"upper")      = q38_cost_prod_crop_labor.up(i);
 oq38_cost_prod_crop_capital(t,i,"upper")    = q38_cost_prod_crop_capital.up(i);
 ov_cost_prod_crop(t,i,factors,"lower")      = vm_cost_prod_crop.lo(i,factors);
 oq38_cost_prod_crop_labor(t,i,"lower")      = q38_cost_prod_crop_labor.lo(i);
 oq38_cost_prod_crop_capital(t,i,"lower")    = q38_cost_prod_crop_capital.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
