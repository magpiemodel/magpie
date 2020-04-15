*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

   ksd(kall) Secondary products
   /oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres/

   kres(kall) Residues
   / res_cereals, res_fibrous, res_nonfibrous /

   k(kall) Primary products
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, pasture, cottn_pro, begr, betr, livst_rum, livst_pig,
         livst_chick, livst_egg, livst_milk, fish /

   kap(k) Animal products
   /
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish
   /

   kli(kap) Livestock products
   / livst_rum, livst_pig, livst_chick, livst_egg, livst_milk  /

   kve(k) Land-use activities
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, pasture, cottn_pro, begr, betr /

   kcr(kve) Cropping activities
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, cottn_pro, begr, betr /
 ;

alias(kap,kap4);
