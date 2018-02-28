*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod(t,i,kall,"marginal")       = vm_cost_prod.m(i,kall);
 oq38_cost_prod_crop(t,i,kcr,"marginal") = q38_cost_prod_crop.m(i,kcr);
 ov_cost_prod(t,i,kall,"level")          = vm_cost_prod.l(i,kall);
 oq38_cost_prod_crop(t,i,kcr,"level")    = q38_cost_prod_crop.l(i,kcr);
 ov_cost_prod(t,i,kall,"upper")          = vm_cost_prod.up(i,kall);
 oq38_cost_prod_crop(t,i,kcr,"upper")    = q38_cost_prod_crop.up(i,kcr);
 ov_cost_prod(t,i,kall,"lower")          = vm_cost_prod.lo(i,kall);
 oq38_cost_prod_crop(t,i,kcr,"lower")    = q38_cost_prod_crop.lo(i,kcr);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

