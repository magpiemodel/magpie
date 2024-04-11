*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
