*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i21_trade_bal_reduction(t_all,k_trade)         Trade balance reduction (1)
 i21_trade_margin(i_ex,i_im,k_trade)            Trade transport and admin costs (USD05MER per tDM)
 i21_trade_tariff(t_all, i_ex,i_im,k_trade)            Trade tariffs (USD05MER per tDM)
;

positive variables
 v21_excess_dem(k_trade)                 Demand exceeding the minimum self-sufficiency (mio. tDM per yr)
 v21_excess_prod(h,k_trade)              Superregional production exceeding the minimum self-sufficiency production (mio. tDM per yr)
 v21_trade(i_ex,i_im,k_trade)            Amounts traded bilaterally (mio. tDM per yr)
 v21_cost_tariff_reg(i,k_trade)          Regional trade tariffs for each tradable commodity (mio. USD05MER per yr)
 v21_cost_margin_reg(i,k_trade)          Rregional trade margins for each tradable commodity (mio. USD05MER per yr)
 vm_cost_trade(i)                        Regional  trade costs (mio. USD05MER per yr)
 v21_cost_trade_reg(i,k_trade)           Superregional trade costs for each tradable commodity (mio. USD05MER per yr)
 v21_import_for_feasibility(h,k_trade)   Additional imports to maintain feasibility (mio. tDM per yr)
;

equations
 q21_trade_glo(k_trade)                  Global production constraint (mio. tDM per yr)
 q21_notrade(h,k_notrade)                Superregional production constraint of non-tradable commodities (mio. tDM per yr)
 q21_trade_reg(h,k_trade)                Superregional trade balances i.e. minimum self-sufficiency ratio (1)
 q21_trade_reg_up(h,k_trade)             Superregional trade balances i.e. maximum self-sufficiency ratio (1)
 q21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 q21_excess_supply(h,k_trade)            Superregional excess production (mio. tDM per yr)
 q21_trade_bilat(h, k_trade)             Superregional bilateral trade requirements (mio. tDM per yr)
 q21_costs_tariffs(i, k_trade)           Regional  trade tariff costs (mio. USD05MER per yr)
 q21_costs_margins(i,k_trade)            Regional bilateral trade requirements
 q21_cost_trade_reg(i,k_trade)           Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 q21_cost_trade_reg(i,k_trade)           Superregional trade costs for each tradable commodity (mio. USD05MER per yr)
 q21_cost_trade(i)                       Superregional  trade costs (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov21_excess_dem(t,k_trade,type)               Demand exceeding the minimum self-sufficiency (mio. tDM per yr)
 ov21_excess_prod(t,h,k_trade,type)            Superregional production exceeding the minimum self-sufficiency production (mio. tDM per yr)
 ov21_trade(t,i_ex,i_im,k_trade,type)          Amounts traded bilaterally (mio. tDM per yr)
 ov21_cost_tariff_reg(t,i,k_trade,type)        Regional trade tariffs for each tradable commodity (mio. USD05MER per yr)
 ov21_cost_margin_reg(t,i,k_trade,type)        Rregional trade margins for each tradable commodity (mio. USD05MER per yr)
 ov_cost_trade(t,i,type)                       Regional  trade costs (mio. USD05MER per yr)
 ov21_cost_trade_reg(t,i,k_trade,type)         Superregional trade costs for each tradable commodity (mio. USD05MER per yr)
 ov21_import_for_feasibility(t,h,k_trade,type) Additional imports to maintain feasibility (mio. tDM per yr)
 oq21_trade_glo(t,k_trade,type)                Global production constraint (mio. tDM per yr)
 oq21_notrade(t,h,k_notrade,type)              Superregional production constraint of non-tradable commodities (mio. tDM per yr)
 oq21_trade_reg(t,h,k_trade,type)              Superregional trade balances i.e. minimum self-sufficiency ratio (1)
 oq21_trade_reg_up(t,h,k_trade,type)           Superregional trade balances i.e. maximum self-sufficiency ratio (1)
 oq21_excess_dem(t,k_trade,type)               Global excess demand (mio. tDM per yr)
 oq21_excess_supply(t,h,k_trade,type)          Superregional excess production (mio. tDM per yr)
 oq21_trade_bilat(t,h,k_trade,type)            Superregional bilateral trade requirements (mio. tDM per yr)
 oq21_costs_tariffs(t,i,k_trade,type)          Regional  trade tariff costs (mio. USD05MER per yr)
 oq21_costs_margins(t,i,k_trade,type)          Regional bilateral trade requirements
 oq21_cost_trade_reg(t,i,k_trade,type)         Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 oq21_cost_trade_reg(t,i,k_trade,type)         Superregional trade costs for each tradable commodity (mio. USD05MER per yr)
 oq21_cost_trade(t,i,type)                     Superregional  trade costs (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
