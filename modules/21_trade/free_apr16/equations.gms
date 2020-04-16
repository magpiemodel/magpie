*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 q21_trade_glo(k_trade).. sum(i2 ,vm_prod_reg(i2,k_trade)) =g= sum(i2, vm_supply(i2,k_trade));

 q21_notrade(i2,k_notrade).. vm_prod_reg(i2,k_notrade) =g= vm_supply(i2,k_notrade);
