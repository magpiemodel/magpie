*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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
;

positive variables
 vm_cost_trade(i)                            Regional  trade costs (mio. USD05MER per yr)
;

equations
 q21_trade_glo(k_trade)          Global production constraint (mio. tDM per yr)
 q21_notrade(i,k_notrade)        Regional production constraint of non-tradable commodities (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_trade(t,i,type)          Regional  trade costs (mio. USD05MER per yr)
 oq21_trade_glo(t,k_trade,type)   Global production constraint (mio. tDM per yr)
 oq21_notrade(t,i,k_notrade,type) Regional production constraint of non-tradable commodities (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
