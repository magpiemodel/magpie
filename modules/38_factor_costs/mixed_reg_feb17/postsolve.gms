*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod_crop(t,i,req,"marginal")   = vm_cost_prod_crop.m(i,req);
 oq38_cost_prod_crop(t,i,req,"marginal") = q38_cost_prod_crop.m(i,req);
 ov_cost_prod_crop(t,i,req,"level")      = vm_cost_prod_crop.l(i,req);
 oq38_cost_prod_crop(t,i,req,"level")    = q38_cost_prod_crop.l(i,req);
 ov_cost_prod_crop(t,i,req,"upper")      = vm_cost_prod_crop.up(i,req);
 oq38_cost_prod_crop(t,i,req,"upper")    = q38_cost_prod_crop.up(i,req);
 ov_cost_prod_crop(t,i,req,"lower")      = vm_cost_prod_crop.lo(i,req);
 oq38_cost_prod_crop(t,i,req,"lower")    = q38_cost_prod_crop.lo(i,req);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
