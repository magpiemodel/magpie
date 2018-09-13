*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets

   ksd(kall) secondary products
   /oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres/

   kres(kall) residues
   / res_cereals, res_fibrous, res_nonfibrous /

   k(kall) products
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, pasture, cottn_pro, begr, betr, livst_rum, livst_pig,
         livst_chick, livst_egg, livst_milk, fish /

   kap(k) Animal products
   /
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish
   /

   kli(kap) livestock products
   / livst_rum, livst_pig, livst_chick, livst_egg, livst_milk  /

   kve(k) land-use activities
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, pasture, cottn_pro, begr, betr /

   kcr(kve) cropping activities
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, cottn_pro, begr, betr /
 ;

alias(kap,kap4);
