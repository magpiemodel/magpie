*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  rotascen30 rotation constraint scenarios
  /min,default,good,good_20div,setaside,legumes,agroforestry,sixfoldrotation,agroecology/

  rotamax30 Maximum crop rotation categories
  / all_max, cereals_excl_rice_max, stalk_max,
    biomass_max, roots_max, legume_max, rape_sugr_max,
    tece_max, maiz_max, trce_max, rice_max,
    rapeseed_max, soybean_max, sunflower_max, groundnut_max,
    oilpalm_max, puls_max, potato_max, cassava_max,
    sugr_cane_max, sugr_beet_max, others_max, foddr_max,
    fiber_max, begr_max, betr_max
  /

  rotamin30 Minimum crop rotation categories
  /
    all_min, stalk_min, biomass_min,
    legume_min, others_min
  /

  rotamax_red30(rotamax30) Maximum crop rotation reduced set
  rotamin_red30(rotamin30) Minimum crop rotation reduced set

* crop rotation groups:
* cereals or grasses are very favourable to loosen soils, therefore minimum constraint
* legumes need longer rotations, only soybean can and is cultivated every 2 years
* rapeseed and beets have same nematodes
* root crops have similar diseases

* Sustainable practices:
* >=5% set-aside, >=5% biomass crops that approximate agroforestry systems
* six fold crop rotation of the remaining 90%
* at least one legume slot in crop rotation
* crop groups with multiple members like tece or foddr are allowed multiple slots
* one percent fruits and vegs in each cell for regional demand

  rotamax_kcr30(rotamax30, kcr) Mapping of crop types into crop rotation types
       / all_max       . (tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, cottn_pro, begr, betr)
         cereals_excl_rice_max   . (tece, maiz, trce)
         stalk_max     . (tece, maiz, trce, rice_pro, sugr_cane, begr, foddr)
         roots_max     . (potato, cassav_sp, sugr_beet)
         legume_max    . (soybean, groundnut, puls_pro, foddr)
         biomass_max   . (sugr_cane, oilpalm, begr, betr)
         rape_sugr_max . (rapeseed, sugr_beet)

         tece_max      . (tece)
         maiz_max      . (maiz)
         trce_max      . (trce)
         rice_max      . (rice_pro)
         rapeseed_max  . (rapeseed)
         soybean_max   . (soybean)
         sunflower_max . (sunflower)
         groundnut_max . (groundnut)
         oilpalm_max   . (oilpalm)
         puls_max      . (puls_pro)
         potato_max    . (potato)
         cassava_max   . (cassav_sp)
         sugr_cane_max . (sugr_cane)
         sugr_beet_max . (sugr_beet)
         others_max    . (others)
         foddr_max     . (foddr)
         fiber_max     . (cottn_pro)
         begr_max      . (begr)
         betr_max      . (betr)  /

 rotamin_kcr30(rotamin30,kcr) Mapping of crop types into crop rotation types
      / all_min       . (tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
        oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
        foddr, cottn_pro, begr, betr)

        stalk_min     . (tece, maiz, trce, rice_pro, sugr_cane, foddr)
        biomass_min   . (sugr_cane, oilpalm, begr, betr)
        legume_min    . (soybean, groundnut, puls_pro, foddr)
        others_min     . (others)
      /


   kbe30(kcr) bio energy activities
        / betr, begr /

   bioen_type_30(kbe30) dynamic set bioen type
   bioen_water_30(w) dynamic set bioen water

   crop_ann30(kcr) annual crops
    / tece, maiz, trce, rice_pro, rapeseed, sunflower, potato, cassav_sp, sugr_beet, others, cottn_pro, foddr, soybean, groundnut, puls_pro /

   crop_per30(kcr) perennial crops
    / oilpalm, begr, sugr_cane, betr /

   marginal_land30 Marginal land scenarios
    / all_marginal, q33_marginal, no_marginal  /

   policy_target30 Target year for cropland policy
   / none, by2030, by2050 /

   relocation_target30 Cropland requiring relocation based on different SNV targets
   / SNV20TargetCropland, SNV50TargetCropland /
;
