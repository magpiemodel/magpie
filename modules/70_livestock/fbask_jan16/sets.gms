*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

   cost_regr Cost regression parameters
    /cost_regr_a,cost_regr_b/

   feed_scen70  scenarios
       / ssp1, ssp2, ssp3, ssp4, ssp5, constant,
         SDP, SDP_EI, SDP_MC, SDP_RC /

   sys Livestock production systems
     /sys_pig, sys_beef, sys_chicken, sys_hen, sys_dairy/

   sys_meat(sys) Livestock meat production systems
     /sys_pig, sys_beef, sys_chicken/

   sys_nonmeat(sys) Livestock non-meat production systems
     /sys_hen, sys_dairy/


  sys_to_kli(sys,kli) Mapping between livestock producton systems and livestock products
  /sys_pig    . livst_pig
   sys_beef    . livst_rum
   sys_chicken  . livst_chick
   sys_hen . livst_egg
   sys_dairy .livst_milk
   /

   kcer70(kall) Cereals
   / tece, maiz, trce, rice_pro /

  fadeoutscen70  Feed substitution scenarios including functional forms with targets and transition periods
       / constant,
         lin_zero_10_50, lin_zero_20_50, lin_zero_20_30, lin_zero_20_70, lin_50pc_20_50, lin_50pc_20_50_extend65, lin_50pc_20_50_extend80,
         lin_50pc_10_50_extend90, lin_75pc_10_50_extend90, lin_80pc_20_50, lin_80pc_20_50_extend95, lin_90pc_20_50_extend95,
	 lin_99-98-90pc_20_50-60-100, sigmoid_20pc_20_50, sigmoid_50pc_20_50, sigmoid_80pc_20_50 /

   ksub70 Set covering kall to allow for substitutions between feed components
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,oilpalm,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro,foddr, pasture, begr, betr,
   oils,oilcakes,sugar,molasses,alcohol,ethanol,distillers_grain,brans,scp,fibres,
   livst_rum, livst_pig,livst_chick, livst_egg, livst_milk, fish,
   res_cereals, res_fibrous, res_nonfibrous, wood, woodfuel
   /



   kall_ksub70(kall,ksub70) Mapping between feed components and possible replacements (currently only residues and fodder replaceable)
       /
       tece   . (tece)
       maiz   . (maiz)
       trce   . (trce)
       rice_pro   . (rice_pro)
       soybean   . (soybean)
       rapeseed   . (rapeseed)
       groundnut   . (groundnut)
       sunflower   . (sunflower)
       oilpalm   . (oilpalm)
       puls_pro   . (puls_pro)
       potato   . (potato)
       cassav_sp   . (cassav_sp)
       sugr_beet   . (sugr_beet)
       others   . (others)
       cottn_pro   . (cottn_pro)
       foddr   . (foddr)
       pasture   . (pasture)
       begr   . (begr)
       betr   . (betr)
       oils   . (oils)
       oilcakes   . (oilcakes)
       sugar   . (sugar)
       molasses   . (molasses)
       alcohol   . (alcohol)
       ethanol   . (ethanol)
       distillers_grain   . (distillers_grain)
       brans   . (brans)
       scp   . (scp)
       fibres   . (fibres)
       livst_rum   . (livst_rum)
       livst_pig   .  (livst_pig)
       livst_chick   .  (livst_chick)
       livst_egg   .  (livst_egg)
       livst_milk   .  (livst_milk)
       fish   . (fish)
       res_cereals   . (foddr)
       res_fibrous   . (foddr)
       res_nonfibrous   . (foddr)
       wood   . (wood)
       woodfuel   . (woodfuel)
       /
;
