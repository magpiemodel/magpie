*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i21_trade_margin(i_ex,i_im,k_trade)                       Bilateral freight and insurance costs between region pairs (USD17MER per tDM)
 i21_trade_tariff(t_all,i_ex,i_im,k_trade)                 Bilateral specific duty tariff rates (USD17MER per tDM)
 i21_import_supply_historical(i_ex,i_im,t_all,k_trade)     Share of importer domestic supply sourced from each exporter - historical and projected (1)
 i21_trade_bilat_stddev(t_all,i_ex,i_im,k_trade)           Standard deviation of historical import supply ratios used as flexibility window (1)
 i21_import_supply_scenario(t_all)                         Time-varying scalar on import supply ratios for scenario experiments (1)
 i21_stddev_lib_factor(t_all)                              Time-varying scalar on the flexibility window width (1)
 p21_import_supply_sum(i_im,t_all,k_trade)                 Sum of import supply ratios across all exporters after scenario scaling - used to cap at 1 (1)
;

variables
 v21_cost_tariff_reg(i,k_trade)          Regional tariff costs summed over all bilateral partners (mio. USD17MER per yr)
;

positive variables
 v21_trade(i_ex,i_im,k_trade)                    Bilateral trade flow from exporter to importer (mio. tDM per yr)
 v21_cost_margin_reg(i,k_trade)                  Regional transport margin costs summed over all bilateral partners (mio. USD17MER per yr)
 vm_cost_trade_tariff(i)                         Regional tariff costs across all commodities entering objective (mio. USD17MER per yr)
 vm_cost_trade_margin(i)                         Regional transport margin costs across all commodities entering objective (mio. USD17MER per yr)
 vm_cost_trade_feasibility(i)                    Regional feasibility penalty costs across all commodities entering objective (mio. USD17MER per yr)
 v21_import_for_feasibility(i_ex,i_im,k_trade)   Additional imports to maintain feasibility (mio. tDM per yr)
;

equations
 q21_notrade(h,k_notrade)                Non-tradable commodities must be produced within their super-region (mio. tDM per yr)
 q21_trade_reg(h,k_trade)                Regional material balance: production covers supply adjusted for net bilateral trade (mio. tDM per yr)
 q21_trade_lower(i_ex,i_im,k_trade)      Lower bound on bilateral trade from historical import supply ratio minus flexibility (mio. tDM per yr)
 q21_trade_upper(i_ex,i_im,k_trade)      Upper bound on bilateral trade from historical import supply ratio plus flexibility (mio. tDM per yr)
 q21_costs_tariffs(i,k_trade)            Bilateral tariff costs assigned to exporting region (mio. USD17MER per yr)
 q21_costs_margins(i,k_trade)            Bilateral transport margin costs assigned to exporting region (mio. USD17MER per yr)
 q21_cost_trade_tariff(i)                Regional tariff costs aggregated over all commodities (mio. USD17MER per yr)
 q21_cost_trade_margin(i)                Regional margin costs aggregated over all commodities (mio. USD17MER per yr)
 q21_cost_trade_feasibility(i)           Regional feasibility penalty costs (mio. USD17MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov21_cost_tariff_reg(t,i,k_trade,type)                Regional tariff costs summed over all bilateral partners (mio. USD17MER per yr)
 ov21_trade(t,i_ex,i_im,k_trade,type)                  Bilateral trade flow from exporter to importer (mio. tDM per yr)
 ov21_cost_margin_reg(t,i,k_trade,type)                Regional transport margin costs summed over all bilateral partners (mio. USD17MER per yr)
 ov_cost_trade_tariff(t,i,type)                        Regional tariff costs across all commodities entering objective (mio. USD17MER per yr)
 ov_cost_trade_margin(t,i,type)                        Regional transport margin costs across all commodities entering objective (mio. USD17MER per yr)
 ov_cost_trade_feasibility(t,i,type)                   Regional feasibility penalty costs across all commodities entering objective (mio. USD17MER per yr)
 ov21_import_for_feasibility(t,i_ex,i_im,k_trade,type) Additional imports to maintain feasibility (mio. tDM per yr)
 oq21_notrade(t,h,k_notrade,type)                      Non-tradable commodities must be produced within their super-region (mio. tDM per yr)
 oq21_trade_reg(t,h,k_trade,type)                      Regional material balance: production covers supply adjusted for net bilateral trade (mio. tDM per yr)
 oq21_trade_lower(t,i_ex,i_im,k_trade,type)            Lower bound on bilateral trade from historical import supply ratio minus flexibility (mio. tDM per yr)
 oq21_trade_upper(t,i_ex,i_im,k_trade,type)            Upper bound on bilateral trade from historical import supply ratio plus flexibility (mio. tDM per yr)
 oq21_costs_tariffs(t,i,k_trade,type)                  Bilateral tariff costs assigned to exporting region (mio. USD17MER per yr)
 oq21_costs_margins(t,i,k_trade,type)                  Bilateral transport margin costs assigned to exporting region (mio. USD17MER per yr)
 oq21_cost_trade_tariff(t,i,type)                      Regional tariff costs aggregated over all commodities (mio. USD17MER per yr)
 oq21_cost_trade_margin(t,i,type)                      Regional margin costs aggregated over all commodities (mio. USD17MER per yr)
 oq21_cost_trade_feasibility(t,i,type)                 Regional feasibility penalty costs (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
