*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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

emis_source_nomethane53(emis_source) emission sources
   / inorg_fert, man_crop, resid, man_past, som,
     resid_burn,
     crop_vegc, crop_litc, crop_soilc,
     past_vegc, past_litc, past_soilc,
     forestry_vegc, forestry_litc, forestry_soilc,
     primforest_vegc, primforest_litc, primforest_soilc,
	 secdforest_vegc, secdforest_litc, secdforest_soilc, 
	 urban_vegc, urban_litc, urban_soilc,
     other_vegc, other_litc, other_soilc,
     beccs /

;
