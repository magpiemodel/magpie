*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(h,tautype)                   Agricultural land use intensity tau (1)
 vm_tech_cost(i)                     Total Annuitized costs of TC (mio. USD17MER per yr)
 v13_cost_tc(i,tautype)              Technical change costs per region (mio. USD17MER)
 v13_tech_cost(i,tautype)            Annuitized costs of TC for crops and pasture (mio. USD17MER per yr)
;

equations
 q13_tech_cost(i, tautype)            Total annuitized costs for TC (mio. USD17MER)
 q13_cost_tc(i, tautype)              Costs for TC (mio. USD17MER per yr)
 q13_tech_cost_sum(i)                 Total Total annuitized costs for TC (mio. USD17MER per yr)
;

parameters
 pc13_land(i, tautype)                Crop and grass land area per region (mio ha)
 pcm_tau(h, tautype)                  Tau factor of the previous time step (1)
 pc13_tcguess(h, tautype)             Guess for annual tc rates in the next time step (1)
 i13_tc_factor(t)                     Regression factor (USD17MER per ha)
 i13_tc_exponent(t)                   Regression exponent (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,h,tautype,type)         Agricultural land use intensity tau (1)
 ov_tech_cost(t,i,type)           Total Annuitized costs of TC (mio. USD17MER per yr)
 ov13_cost_tc(t,i,tautype,type)   Technical change costs per region (mio. USD17MER)
 ov13_tech_cost(t,i,tautype,type) Annuitized costs of TC for crops and pasture (mio. USD17MER per yr)
 oq13_tech_cost(t,i,tautype,type) Total annuitized costs for TC (mio. USD17MER)
 oq13_cost_tc(t,i,tautype,type)   Costs for TC (mio. USD17MER per yr)
 oq13_tech_cost_sum(t,i,type)     Total Total annuitized costs for TC (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
