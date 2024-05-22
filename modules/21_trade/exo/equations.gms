*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' The regional production must be larger than the regional demand plus exports
*' from that region (or minus imports in case of a negative trade balance).

q21_notrade(h2,kall)..
 sum(supreg(h2,i2),vm_prod_reg(i2,kall)) =g= sum(supreg(h2,i2), vm_supply(i2,kall))
 + sum(ct,f21_trade_balance(ct,h2,kall));
