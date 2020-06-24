*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q38_cost_prod_crop(i,kcr)      Regional factor input costs for plant production (mio. USD05MER per yr)
 q38_cost_prod_inv(i)           Regional investment costs in capital (mio USD05MER)
;

positive variables
vm_cost_prod(i,kall)             Factor costs (mio. USD05MER per yr)
 vm_cost_inv(i)           Capital investment costs (mio USD05MER  per yr)
;

parameters
p38_ovcosts(t,i,kcr)             Overall factor costs (mio USD05MER)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_prod(t,i,kall,type)       Factor costs (mio. USD05MER per yr)
 oq38_cost_prod_crop(t,i,kcr,type) Regional factor input costs for plant production (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
