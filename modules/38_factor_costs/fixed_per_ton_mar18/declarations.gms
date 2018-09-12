*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)               Regional factor input costs for plant production (mio. USD05MER)
;

positive variables
         vm_cost_prod(i,kall)            Factor costs (mio. USD05MER)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)       Factor costs (mio. USD05MER)
 oq38_cost_prod_crop(t,i,kcr,type) Regional factor input costs for plant production (mio. USD05MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
