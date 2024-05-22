*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_cost_trade(i)                            Regional  trade costs (mio. USD05MER per yr)
;

equations
 q21_notrade(h,kall)   Superregional production constraint of non-tradable commodities (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_trade(t,i,type)     Regional  trade costs (mio. USD05MER per yr)
 oq21_notrade(t,h,kall,type) Superregional production constraint of non-tradable commodities (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
