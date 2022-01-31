*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(h,tautype)                   Agricultural land use intensity tau (1)
 vm_tech_cost(i,tautype)             Annuitized costs of TC (mio. USD05PPP per yr)
 v13_cost_tc(i,tautype)              Technical change costs per region (mio. USD05PPP)
;

equations
 q13_tech_cost(i, tautype)            Total annuitized costs for TC (mio. USD05PPP)
 q13_cost_tc(i, tautype)              Costs for TC (mio. USD05PPP per yr)
;

parameters
 pc13_land(i, tautype)                Crop and grass land area per region (mio ha)
 pcm_tau(h, tautype)                  Tau factor of the previous time step (1)
 pc13_tcguess(h, tautype)             Guess for annual tc rates in the next time step (1)
 i13_tc_factor(t, tautype)            Regression factor (USD05PPP per ha)
 i13_tc_exponent(t,tautype)           Regression exponent (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,h,tautype,type)         Agricultural land use intensity tau (1)
 ov_tech_cost(t,i,tautype,type)   Annuitized costs of TC (mio. USD05PPP per yr)
 ov13_cost_tc(t,i,tautype,type)   Technical change costs per region (mio. USD05PPP)
 oq13_tech_cost(t,i,tautype,type) Total annuitized costs for TC (mio. USD05PPP)
 oq13_cost_tc(t,i,tautype,type)   Costs for TC (mio. USD05PPP per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
