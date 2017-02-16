*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_mi(t,i,"marginal")                   = vm_mi.m(i);
 ov_cost_prod(t,i,k,"marginal")          = vm_cost_prod.m(i,k);
 oq38_cost_prod_crop(t,i,kcr,"marginal") = q38_cost_prod_crop.m(i,kcr);
 ov_mi(t,i,"level")                      = vm_mi.l(i);
 ov_cost_prod(t,i,k,"level")             = vm_cost_prod.l(i,k);
 oq38_cost_prod_crop(t,i,kcr,"level")    = q38_cost_prod_crop.l(i,kcr);
 ov_mi(t,i,"upper")                      = vm_mi.up(i);
 ov_cost_prod(t,i,k,"upper")             = vm_cost_prod.up(i,k);
 oq38_cost_prod_crop(t,i,kcr,"upper")    = q38_cost_prod_crop.up(i,kcr);
 ov_mi(t,i,"lower")                      = vm_mi.lo(i);
 ov_cost_prod(t,i,k,"lower")             = vm_cost_prod.lo(i,k);
 oq38_cost_prod_crop(t,i,kcr,"lower")    = q38_cost_prod_crop.lo(i,kcr);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

