*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' For traded goods the only active constraint is that the global supply is larger or equal to demand.
*' This means that production can be freely allocated globally based on comparative advantages.

q21_trade_glo(k_trade).. sum(i2 ,vm_prod_reg(i2,k_trade)) =g= sum(i2, vm_supply(i2,k_trade));

*'
*' For non-tradable commodites, the regional supply should be larger or equal to the regional demand.

 q21_notrade(h2,k_notrade)..
   sum(supreg(h2,i2),vm_prod_reg(i2,k_notrade)) =g= sum(supreg(h2,i2), vm_supply(i2,k_notrade));
