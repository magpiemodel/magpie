*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  rotascen30 rotation constraint scenarios
  / none, min, default, good, good_20div, legumes, agroforestry, agroecology /

  rota30 rotational rules
  / cereals_excl_rice_max, stalk_max,
    legumes_max, roots_max, rape_sugr_max, biomass_max,
    tece_max, maiz_max, trce_max, rice_max,
    rapeseed_max, soybean_max, sunflower_max, groundnut_max,
    oilpalm_max, puls_max, potato_max, cassava_max,
    sugr_cane_max, sugr_beet_max, others_max, foddr_max,
    fiber_max, begr_max, betr_max
    biomass_min, legumes_min, stalk_min, others_min /

  rotamax30(rota30) rotational maximum rules
  / cereals_excl_rice_max, stalk_max,
    legumes_max, roots_max, rape_sugr_max, biomass_max,
    tece_max, maiz_max, trce_max, rice_max,
    rapeseed_max, soybean_max, sunflower_max, groundnut_max,
    oilpalm_max, puls_max, potato_max, cassava_max,
    sugr_cane_max, sugr_beet_max, others_max, foddr_max,
    fiber_max, begr_max, betr_max /

  rotamin30(rota30) rotational minimum rules
  / biomass_min, legumes_min, stalk_min, others_min /

  rotamax_red30(rotamax30) Maximum crop rotation reduced set
  rotamin_red30(rotamin30) Minimum crop rotation reduced set

* crop rotation groups:
* cereals or grasses are very favourable to loosen soils, therefore minimum constraint
* legumes need longer rotations, only soybean can and is cultivated every 2 years
* rapeseed and beets have same nematodes
* root crops have similar diseases

* Sustainable practices:
* >=5% biomass crops that approximate agroforestry systems
* at least one legume slot in crop rotation
* crop groups with multiple members like tece or foddr are allowed multiple slots
* one percent fruits and vegs in each cell for regional demand

  rota_kcr30(rota30, kcr) Mapping of crop types into crop rotation types
       / cereals_excl_rice_max   . (tece, maiz, trce)
         stalk_max      . (tece, maiz, trce, rice_pro, sugr_cane, begr, foddr)
         legumes_max    . (foddr, puls_pro, soybean, groundnut)
         roots_max      . (sugr_beet, cassav_sp, potato)
         rape_sugr_max  . (rapeseed, sugr_beet)
         biomass_max    . (sugr_cane, oilpalm, begr, betr)

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
         betr_max      . (betr)

         biomass_min    . (sugr_cane, oilpalm, begr, betr)
         legumes_min    . (soybean, groundnut, puls_pro, foddr)
         stalk_min      . (tece, maiz, trce, rice_pro, sugr_cane, foddr)
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

;
