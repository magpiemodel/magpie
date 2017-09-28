*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(i)                       agricultural land use intensity tau (1)
 vm_tech_cost(i)                 costs of technological change (mio. US$)
 v13_cost_tc(i)                  technical change costs per region -general (million US$)
 v13_tech_cost_annuity(i)        annuity costs of technological change (mio. US$)
 
*add
 v13_cost_tc_part1(i)            technical change costs per region -for observed tau (million US$)
 v13_cost_tc_part2(i)            technical change costs per region -for unobserved tau (million US$)
 v13_cost_tc_agg(i)              technical change costs per region -for continuous tau (million US$)
;

equations
 q13_tech_cost(i)                  total costs for technological change
 q13_cost_tc(i)                    costs for technological change
 q13_tech_cost_annuity(i)          annuity costs for technological change

*add
 q13_cost_tc_part1(i)              costs for technological change (for observed tau)
 q13_cost_tc_part2(i)              costs for technological change (for unobserved tau)
 q13_cost_tc_agg(i)                costs for technological change (for continuous tau)
 ;

parameters
 i13_land(i)                       crop land area per region (mio ha.)
 pc13_tau(i)                       tau factor of the previous time step (1)
 p13_tech_cost_past(t,i)           costs for technological change from past (million US$)
 pc13_tech_cost_past(i)            current costs for technological change from past (million US$)
 pc13_tcguess(i)                   guess for annual tc rates in the next time step (1))
 i13_tc_factor(t,i)            		 regression factor
 i13_tc_exponent(t,i)          		 regression exponent
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,i,type)                 agricultural land use intensity tau (1)
 ov_tech_cost(t,i,type)           costs of technological change (mio. US$)
 ov13_cost_tc(t,i,type)           technical change costs per region (million US$)
 ov13_tech_cost_annuity(t,i,type) annuity costs of technological change (mio. US$)
 oq13_tech_cost(t,i,type)         total costs for technological change
 oq13_cost_tc(t,i,type)           costs for technological change
 oq13_tech_cost_annuity(t,i,type) annuity costs for technological change

*add
 ov13_cost_tc_part1(t,i,type)           technical change costs per region-for observed tau (million US$)
 ov13_cost_tc_part2(t,i,type)           technical change costs per region-for unobserved tau (million US$)
 ov13_cost_tc_agg(t,i,type)             technical change costs per region-for continuous tau (million US$)
;
*parameters
*bound value for part2
*v13_cost_tc_part2.fx(i2)$(vm_tau(i) < 1.6) = 0 ;

*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
