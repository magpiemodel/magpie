*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_cost_trade(i)                            Regional  trade costs (mio. USD05MER per yr)
 vm_prod_future_reg_ff(i,kforestry)     Future production of timber based (mio. m3)
 v21_excess_prod_ff(i,kforestry)        Excess future production of timber (mio. m3)
 v21_excess_dem_ff(kforestry)            Excess future demand of timber (mio. m3)
 v21_excess_prod_ff(i,kforestry)        Excess future production of timber (mio. m3)
 v21_cost_trade_reg_ff(i,kforestry)     Future trade costs for timber (mio. USD)
 vm_cost_trade_forestry_ff(i)           Future total timber trade costs (mio. USD)
;

equations
 q21_trade_glo(k_trade)          Global production constraint (mio. tDM per yr)
 q21_notrade(i,k_notrade)        Regional production constraint of non-tradable commodities (mio. tDM per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_trade(t,i,type)                    Regional  trade costs (mio. USD05MER per yr)
 ov_prod_future_reg_ff(t,i,kforestry,type)  Future production of timber based (mio. m3)
 ov21_excess_prod_ff(t,i,kforestry,type)    Excess future production of timber (mio. m3)
 ov21_excess_dem_ff(t,kforestry,type)       Excess future demand of timber (mio. m3)
 ov21_excess_prod_ff(t,i,kforestry,type)    Excess future production of timber (mio. m3)
 ov21_cost_trade_reg_ff(t,i,kforestry,type) Future trade costs for timber (mio. USD)
 ov_cost_trade_forestry_ff(t,i,type)        Future total timber trade costs (mio. USD)
 oq21_trade_glo(t,k_trade,type)             Global production constraint (mio. tDM per yr)
 oq21_notrade(t,i,k_notrade,type)           Regional production constraint of non-tradable commodities (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
