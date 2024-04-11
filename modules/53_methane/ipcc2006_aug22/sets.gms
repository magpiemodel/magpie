*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

k_conc53(kall) feedstuff with high energy content
   / tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro,
   oils,oilcakes,sugar,molasses,distillers_grain,brans,scp,
   livst_rum, livst_pig,livst_chick, livst_egg, fish /

k_noconc53(kall) non-concentrates
   / pasture, foddr, res_cereals, res_fibrous, res_nonfibrous /

k_ruminants53(kli) ruminant subset
   / livst_rum, livst_milk /

emis_source_methane53(emis_source) emission sources
   / awms, rice, ent_ferm, resid_burn /

;
