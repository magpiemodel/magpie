*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(i)                   Agricultural land use intensity tau (1)
 vm_tech_cost(i)             Costs of TC (mio. USD05PPP per yr)
 v13_cost_tc(i)              Technical change costs per region (mio. USD05PPP)
 v13_tech_cost_annuity(i)    Annuity costs of TC (mio. USD05PPP per yr)
;

equations
 q13_tech_cost(i)            Total costs for TC (mio. USD05PPP)
 q13_cost_tc(i)              Costs for TC (mio. USD05PPP per yr)
 q13_tech_cost_annuity(i)    Annuity costs for TC (mio. USD05PPP per yr)
;

parameters
 pc13_land(i)                Crop land area per region (mio ha)
 pc13_tau(i)                 Tau factor of the previous time step (1)
 p13_tech_cost_past(t,i)     Costs for TC from past (mio. USD05PPP per yr)
 pc13_tech_cost_past(i)      Current costs for TC from past (mio. USD05PPP per yr)
 pc13_tcguess(i)             Guess for annual tc rates in the next time step (1)
 i13_tc_factor(t,i)          Regression factor (USD05PPP per ha)
 i13_tc_exponent(t,i)        Regression exponent (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,i,type)                 Agricultural land use intensity tau (1)
 ov_tech_cost(t,i,type)           Costs of TC (mio. USD05PPP per yr)
 ov13_cost_tc(t,i,type)           Technical change costs per region (mio. USD05PPP)
 ov13_tech_cost_annuity(t,i,type) Annuity costs of TC (mio. USD05PPP per yr)
 oq13_tech_cost(t,i,type)         Total costs for TC (mio. USD05PPP)
 oq13_cost_tc(t,i,type)           Costs for TC (mio. USD05PPP per yr)
 oq13_tech_cost_annuity(t,i,type) Annuity costs for TC (mio. USD05PPP per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
