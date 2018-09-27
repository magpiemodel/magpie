*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
  tstart21(t_all) Historic time steps
    / y1995, y2000, y2005, y2010 /

*sets need to be adopted to new categories
   k_notrade(kall) Production activities of non-tradable commodites
       / oilpalm, foddr, pasture, res_cereals, res_fibrous, res_nonfibrous,wood,woodfuel /
* oilpalm not traded, only its oil and oilcake due to FAOSTAT complications, and as trade is little
* foddr is not traded as too bulky
* pasture ist not traded as too bulky
   k_trade(kall) Production activities of tradable commodities
   / tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro, begr, betr,
   oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres,
   livst_rum, livst_pig,livst_chick, livst_egg, livst_milk, fish /

* We limit trade of secondary products as this allows for extreme specialisation
* in the implementation. Exception is sugar, where we allow the secondary product
* trade but not the primary as primaries are hardly traded in reality
   k_hardtrade21(k_trade) Products where trade should be limited
   / sugr_cane,sugr_beet,
   oils,oilcakes,alcohol,ethanol,distillers_grain,brans,scp,fibres,
   livst_rum, livst_pig,livst_chick, livst_egg, livst_milk, fish /

   trade_regime21 Trade scenarios
   /
   free2000,
   regionalized,
   globalized,
   fragmented,
   a909090,
   a908080,
   a909595,
   a808080,
   a807070,
   a809090,
   l909090r808080,
   l908080r807070,
   l909595r809090
   /

   trade_groups21 Trade groups
   / easytrade,hardtrade /

;
