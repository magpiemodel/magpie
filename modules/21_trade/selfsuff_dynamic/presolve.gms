*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc21_trade_bal_reduction(k_trade) = i21_trade_bal_reduction(t,k_trade);
v21_trade_bal_reduction.fx(k_trade) = i21_trade_bal_reduction(t,k_trade);
if(m_year(t) <= 2050,
 v21_trade_bal_reduction.fx("wood") = i21_trade_bal_reduction(t,"wood");
 v21_trade_bal_reduction.fx("woodfuel") = i21_trade_bal_reduction(t,"woodfuel");
else 
 v21_trade_bal_reduction.up("wood") = i21_trade_bal_reduction(t,"wood");
 v21_trade_bal_reduction.l("wood") = i21_trade_bal_reduction(t,"wood");
 v21_trade_bal_reduction.lo("wood") = 0.5;
 v21_trade_bal_reduction.up("woodfuel") = i21_trade_bal_reduction(t,"woodfuel");
 v21_trade_bal_reduction.l("woodfuel") = i21_trade_bal_reduction(t,"woodfuel");
 v21_trade_bal_reduction.lo("woodfuel") = 0.5;
);