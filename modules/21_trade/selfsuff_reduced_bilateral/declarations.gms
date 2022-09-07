*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i21_trade_bal_reduction(t_all,k_trade)         Trade balance reduction (1)
 i21_trade_margin(h_ex,h_im,k_trade)            Trade margins (USD05MER per tDM)
 i21_trade_tariff(h_ex,h_im,k_trade)                    Trade tariffs (USD05MER per tDM)
 pm_selfsuff_ext(t_ext,h,kforestry)            Self sufficiency for timber products in extended time frame (1)
;

positive variables
 v21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 v21_excess_prod(h,k_trade)              Superregional excess production (mio. tDM per yr)
 vm_cost_trade(i)                        Regional  trade costs (mio. USD05MER per yr)
 v21_cost_tariff_reg(h,k_trade)         Superregional trade tariffs for each tradable commodity (mio. USD05MER per yr)
 v21_cost_transport_reg(h,k_trade)       Superregional trade margins for each tradable commodity (mio. USD05MER per yr)
 v21_trade(h_ex,h_im,k_trade)            Amounts traded bilaterally (mio. tDM per yr)
;

equations
 q21_trade_glo(k_trade)                  Global production constraint (mio. tDM per yr)
 q21_notrade(h,k_notrade)                Superregional production constraint of non-tradable commodities (mio. tDM per yr)
 q21_trade_reg(h,k_trade)                Superregional trade balances i.e. minimum self-sufficiency ratio (1)
 q21_trade_reg_up(h,k_trade)             Superregional trade balances i.e. maximum self-sufficiency ratio (1)
 q21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 q21_excess_supply(h,k_trade)            Superregional excess production (mio. tDM per yr)
 q21_cost_trade(h)                       Superregional  trade costs (mio. USD05MER per yr)
 q21_cost_trade_reg(h,k_trade)           Superregional trade costs for each tradable commodity (mio. USD05MER per yr)
 q21_trade_bilat(h, k_trade)             Superregional bilateral trade requirements
 q21_costs_margins(h,k_trade)            Superregional bilateral trade requirements
 
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov21_excess_dem(t,k_trade,type)           Global excess demand (mio. tDM per yr)
 ov21_excess_prod(t,h,k_trade,type)        Superregional excess production (mio. tDM per yr)
 ov_cost_trade(t,i,type)                   Regional  trade costs (mio. USD05MER per yr)
 ov21_cost_tariff_reg(t,h,k_trade,type)    Superregional trade tariffs for each tradable commodity (mio. USD05MER per yr)
 ov21_cost_transport_reg(t,h,k_trade,type) Superregional trade margins for each tradable commodity (mio. USD05MER per yr)
 ov21_trade(t,h_ex,h_im,k_trade,type)      Amounts traded bilaterally (mio. tDM per yr)
 oq21_trade_glo(t,k_trade,type)            Global production constraint (mio. tDM per yr)
 oq21_notrade(t,h,k_notrade,type)          Superregional production constraint of non-tradable commodities (mio. tDM per yr)
 oq21_trade_reg(t,h,k_trade,type)          Superregional trade balances i.e. minimum self-sufficiency ratio (1)
 oq21_trade_reg_up(t,h,k_trade,type)       Superregional trade balances i.e. maximum self-sufficiency ratio (1)
 oq21_excess_dem(t,k_trade,type)           Global excess demand (mio. tDM per yr)
 oq21_excess_supply(t,h,k_trade,type)      Superregional excess production (mio. tDM per yr)
 oq21_cost_trade(t,h,type)                 Superregional  trade costs (mio. USD05MER per yr)
 oq21_cost_trade_reg(t,h,k_trade,type)     Superregional trade costs for each tradable commodity (mio. USD05MER per yr)
 oq21_trade_bilat(t,h,k_trade,type)        Superregional bilateral trade requirements
 oq21_costs_bilateral(t,h,k_trade,type)    Superregional bilateral trade requirements
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
