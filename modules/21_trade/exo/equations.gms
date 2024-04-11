*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

q21_notrade(h2,kall)..
 sum(supreg(h2,i2),vm_prod_reg(i2,kall)) =g= sum(supreg(h2,i2), vm_supply(i2,kall))
 + sum(ct,f21_trade_balance(ct,h2,kall)) - v21_manna_from_heaven(h2,kall);


*' The regional production must be bigger than the regional demand plus exports
*' from that region (or minus imports in case of a negative trade balance). As
*' the trade balance in this realization is exogenously defined there is the
*' imminent risk of infeasibilities. To get results even in case of infeasble
*' trade balance conditions `v21_manna_from_heaven` is introduced. It is an
*' unlimited, but heavily expensive resource which can be used as last resort,
*' if in any other case the model would become infeasible.

q21_cost_trade(h2).. sum(supreg(h2,i2),vm_cost_trade(i2)) =e=
                   10**6 * sum(kall,v21_manna_from_heaven(h2,kall));

*' After each run trade costs `vm_cost_trade` as well as `v21_manna_from_heaven`
*' should be checked for non-zero values as these will indicate inconsistencies
*' between model simulation and exogenously provided trade balances.
