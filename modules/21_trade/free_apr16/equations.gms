*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

 q21_trade_glo(k_trade).. sum(i2 ,vm_prod_reg(i2,k_trade)) =g= sum(i2, vm_supply(i2,k_trade));

 q21_notrade(i2,k_notrade).. vm_prod_reg(i2,k_notrade) =g= vm_supply(i2,k_notrade);
