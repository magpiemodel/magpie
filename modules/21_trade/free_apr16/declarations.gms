*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_cost_trade(i)                            transport costs and taxes for the bilateral trade (Mio USD)
;

equations
 q21_trade_glo(k_trade)          Global production > demand constraint
 q21_notrade(i,k_notrade)        fix of not traded commodities
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_trade(t,i,type)          transport costs and taxes for the bilateral trade (Mio USD)
 oq21_trade_glo(t,k_trade,type)   Global production > demand constraint
 oq21_notrade(t,i,k_notrade,type) fix of not traded commodities
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
