*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(i)                       agricultural land use intensity tau (1)
 vm_tech_cost(i)                 costs of technological change (mio. USD)
 v13_cost_tc(i)                  technical change costs per region (mio. USD)
 v13_tech_cost_annuity(i)        annuity costs of technological change (mio. USD)
;

equations
 q13_tech_cost(i)                  total costs for technological change (mio. USD)
 q13_cost_tc(i)                    costs for technological change (mio. USD)
 q13_tech_cost_annuity(i)          annuity costs for technological change (mio. USD)
;

parameters
 i13_land(i)                 crop land area per region (mio ha)
 pc13_tau(i)                 tau factor of the previous time step (1)
 p13_tech_cost_past(t,i)     costs for technological change from past (mio. USD)
 pc13_tech_cost_past(i)      current costs for technological change from past (mio. USD)
 pc13_tcguess(i)             guess for annual tc rates in the next time step (1)
 i13_tc_factor(t,i)          regression factor (USD per ha)
 i13_tc_exponent(t,i)        regression exponent (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,i,type)                 agricultural land use intensity tau (1)
 ov_tech_cost(t,i,type)           costs of technological change (mio. USD)
 ov13_cost_tc(t,i,type)           technical change costs per region (mio. USD)
 ov13_tech_cost_annuity(t,i,type) annuity costs of technological change (mio. USD)
 oq13_tech_cost(t,i,type)         total costs for technological change (mio. USD)
 oq13_cost_tc(t,i,type)           costs for technological change (mio. USD)
 oq13_tech_cost_annuity(t,i,type) annuity costs for technological change (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
