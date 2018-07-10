*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)                      regional factor input costs for plant production (mio. USD)
;

positive variables   
         vm_cost_prod(i,kall)                   factor costs (mio. USD)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)       factor costs (mio. USD)
 oq38_cost_prod_crop(t,i,kcr,type) regional factor input costs for plant production (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
