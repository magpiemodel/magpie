*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


sets
  tstart21(t_all)
    / y1995, y2000, y2005 /

*sets need to be adopted to new categories
   k_notrade(kall) production activities
       / oilpalm, foddr, pasture, res_cereals, res_fibrous, res_nonfibrous /
* oilpalm not traded, only its oil and oilcake due to FAOSTAT complications, and as trade is little
* foddr is not traded as too bulky
* pasture ist not traded as too bulky
   k_trade(kall)
       /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro, begr, betr,
   oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres,
   livst_rum, livst_pig,livst_chick, livst_egg, livst_milk, fish
   /
;
