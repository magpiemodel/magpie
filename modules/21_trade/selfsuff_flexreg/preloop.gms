*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de



*set vm_cost_trade zero in order to avoid a free variable
vm_cost_trade.fx(i)               = 0;


i21_trade_bal_reduction("y1995",k_trade) = 1;

loop (t$(ord(t)>1),
  i21_trade_bal_reduction(t,k_trade) = i21_trade_bal_reduction(t-1,k_trade)*(1-f21_trade_bal_reduction_annual(t,k_trade))**m_yeardiff(t);
);
