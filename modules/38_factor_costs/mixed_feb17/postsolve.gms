*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p38_ovcosts(t,i,kcr)   = vm_cost_prod.l(i,kcr);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod(t,i,kall,"marginal")       = vm_cost_prod.m(i,kall);
 ov_cost_inv(t,i,"marginal")             = vm_cost_inv.m(i);
 oq38_cost_prod_crop(t,i,kcr,"marginal") = q38_cost_prod_crop.m(i,kcr);
 ov_cost_prod(t,i,kall,"level")          = vm_cost_prod.l(i,kall);
 ov_cost_inv(t,i,"level")                = vm_cost_inv.l(i);
 oq38_cost_prod_crop(t,i,kcr,"level")    = q38_cost_prod_crop.l(i,kcr);
 ov_cost_prod(t,i,kall,"upper")          = vm_cost_prod.up(i,kall);
 ov_cost_inv(t,i,"upper")                = vm_cost_inv.up(i);
 oq38_cost_prod_crop(t,i,kcr,"upper")    = q38_cost_prod_crop.up(i,kcr);
 ov_cost_prod(t,i,kall,"lower")          = vm_cost_prod.lo(i,kall);
 ov_cost_inv(t,i,"lower")                = vm_cost_inv.lo(i);
 oq38_cost_prod_crop(t,i,kcr,"lower")    = q38_cost_prod_crop.lo(i,kcr);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
