*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameters
 i21_trade_margin(h,k_trade)                    Trade margins (USD17MER per tDM)
 i21_trade_tariff(h,k_trade)                    Trade tariffs (USD17MER per tDM)
;

positive variables
 vm_cost_trade(i)                        Regional  trade costs (mio. USD17MER per yr)
 v21_cost_trade_reg(h,k_trade)           Superregional trade costs for each tradable commodity (mio. USD17MER per yr)
;

equations
 q21_notrade(h,kall)                     Superregional production constraint of non-tradable commodities (mio. tDM per yr)
 q21_cost_trade(h)                       Superregional  trade costs (mio. USD17MER per yr)
 q21_cost_trade_reg(h,k_trade)           Superregional trade costs for each tradable commodity (mio. USD17MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_trade(t,i,type)               Regional  trade costs (mio. USD17MER per yr)
 ov21_cost_trade_reg(t,h,k_trade,type) Superregional trade costs for each tradable commodity (mio. USD17MER per yr)
 oq21_notrade(t,h,kall,type)           Superregional production constraint of non-tradable commodities (mio. tDM per yr)
 oq21_cost_trade(t,h,type)             Superregional  trade costs (mio. USD17MER per yr)
 oq21_cost_trade_reg(t,h,k_trade,type) Superregional trade costs for each tradable commodity (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
