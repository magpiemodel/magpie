*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

variables
 vm_cost_glo                     Total costs of production (mio. USD05MER per yr)
 v11_cost_reg(i)                 Regional costs            (mio. USD05MER per yr)
;

equations
 q11_cost_glo                    Objective function        (mio. USD05MER per yr)
 q11_cost_reg(i)                 Regional cost constraint  (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_glo(t,type)     Total costs of production (mio. USD05MER per yr)
 ov11_cost_reg(t,i,type) Regional costs            (mio. USD05MER per yr)
 oq11_cost_glo(t,type)   Objective function        (mio. USD05MER per yr)
 oq11_cost_reg(t,i,type) Regional cost constraint  (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
