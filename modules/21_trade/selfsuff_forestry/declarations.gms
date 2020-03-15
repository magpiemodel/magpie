*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i21_trade_bal_reduction(t_all,k_trade)         Trade balance reduction (1)
 i21_trade_margin(i,k_trade)                    Trade margins (USD05MER per tDM)
 i21_trade_tariff(i,k_trade)                    Trade tariffs (USD05MER per tDM)
 pm_selfsuff_ext(t_ext,i,kforestry)            Self sufficiency for timber products in extended time frame (1)
 p21_criterion	blub
 p21_prices(i,k_trade) blub
 p21_prices_reg(i,k_trade) blub
 p21_prices_glo(k_trade) blub
;

positive variables
 v21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 v21_excess_prod(i,k_trade)              Regional excess production (mio. tDM per yr)
 vm_cost_trade(i)                        Regional  trade costs (mio. USD05MER per yr)
 v21_cost_trade_reg(i,k_trade)           Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 v21_cost_import(i,k_trade)		blub
 v21_cost_export(i,k_trade)		blub
;

variables
 v21_trade_bal(i,k_trade)					blub
;

equations
 q21_trade_glo(k_trade)                  Global production constraint (mio. tDM per yr)
 q21_notrade(i,k_notrade)                Regional production constraint of non-tradable commodities (mio. tDM per yr)
 q21_trade_reg(i,k_trade)                Regional trade balances i.e. minimum self-sufficiency ratio (1)
 q21_trade_reg_up(i,k_trade)             Regional trade balances i.e. maximum self-sufficiency ratio (1)
 q21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 q21_excess_supply(i,k_trade)            Regional excess production (mio. tDM per yr)
 q21_cost_trade(i)                       Regional  trade costs (mio. USD05MER per yr)
 q21_cost_trade_reg(i,k_trade)           Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 q21_trade_balance(k_trade)				blub
 q21_cost_import(i,k_trade)				blub
 q21_cost_export(i,k_trade)				blub
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov21_excess_dem(t,k_trade,type)       Global excess demand (mio. tDM per yr)
 ov21_excess_prod(t,i,k_trade,type)    Regional excess production (mio. tDM per yr)
 ov_cost_trade(t,i,type)               Regional  trade costs (mio. USD05MER per yr)
 ov21_cost_trade_reg(t,i,k_trade,type) Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 ov21_cost_import(t,i,k_trade,type)    blub
 ov21_cost_export(t,i,k_trade,type)    blub
 ov21_trade_bal(t,i,k_trade,type)      blub
 oq21_trade_glo(t,k_trade,type)        Global production constraint (mio. tDM per yr)
 oq21_notrade(t,i,k_notrade,type)      Regional production constraint of non-tradable commodities (mio. tDM per yr)
 oq21_trade_reg(t,i,k_trade,type)      Regional trade balances i.e. minimum self-sufficiency ratio (1)
 oq21_trade_reg_up(t,i,k_trade,type)   Regional trade balances i.e. maximum self-sufficiency ratio (1)
 oq21_excess_dem(t,k_trade,type)       Global excess demand (mio. tDM per yr)
 oq21_excess_supply(t,i,k_trade,type)  Regional excess production (mio. tDM per yr)
 oq21_cost_trade(t,i,type)             Regional  trade costs (mio. USD05MER per yr)
 oq21_cost_trade_reg(t,i,k_trade,type) Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 oq21_trade_balance(t,k_trade,type)    blub
 oq21_cost_import(t,i,k_trade,type)    blub
 oq21_cost_export(t,i,k_trade,type)    blub
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
