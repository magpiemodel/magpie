*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(h,tautype)           Agricultural land use intensity tau (1)
 vm_tech_cost(i)             Costs of TC (mio. USD05PPP per yr)
;

parameters
 p13_cost_tc(i,tautype)      Technical change costs per region (mio. USD05PPP)
 pc13_land(i,tautype)        Crop and grass land area per region (mio ha)
 pcm_tau(h,tautype)          Tau factor of the previous time step (1)
 i13_tc_factor(t)            Regression factor (USD05PPP per ha)
 i13_tc_exponent(t)          Regression exponent (1)
 p13_tech_cost(i,tautype)    Annuitized costs of TC for crops and pasture (mio. USD05PPP per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,h,tautype,type) Agricultural land use intensity tau (1)
 ov_tech_cost(t,i,type)   Costs of TC (mio. USD05PPP per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
