*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_cost_trade(i)                            Regional  trade costs (mio. USD05MER)
;

equations
 q21_trade_glo(k_trade)          Global production constraint (mio. tDM)
 q21_notrade(i,k_notrade)        Regional production constraint of non-tradable commodities (mio. tDM)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_trade(t,i,type)          Regional  trade costs (mio. USD05MER)
 oq21_trade_glo(t,k_trade,type)   Global production constraint (mio. tDM)
 oq21_notrade(t,i,k_notrade,type) Regional production constraint of non-tradable commodities (mio. tDM)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
