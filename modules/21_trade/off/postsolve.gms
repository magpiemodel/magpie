*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")  = vm_cost_trade.m(i);
 oq21_notrade(t,i,k,"marginal") = q21_notrade.m(i,k);
 ov_cost_trade(t,i,"level")     = vm_cost_trade.l(i);
 oq21_notrade(t,i,k,"level")    = q21_notrade.l(i,k);
 ov_cost_trade(t,i,"upper")     = vm_cost_trade.up(i);
 oq21_notrade(t,i,k,"upper")    = q21_notrade.up(i,k);
 ov_cost_trade(t,i,"lower")     = vm_cost_trade.lo(i);
 oq21_notrade(t,i,k,"lower")    = q21_notrade.lo(i,k);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
