*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  rotascen30 rotation constraint scenarios
  /none,  default,  fallow, legumes,  agroforestry, agroecology/

  rota30 rotational rules
  /all1_max, all2_max,
   cereals1_max, cereals2_max,
   resistant_max, oilcrops_max,
   legumes_max, rootsrape_max,
   rice_pro_max, tece_max
   trce_max, maiz_max,
   biomass_min, legumes_min,
   minor_min, cereals_min/


  rotamax30(rota30) rotational maximum rules
  /all1_max, all2_max,
   cereals1_max, cereals2_max,
   resistant_max, oilcrops_max,
   legumes_max, rootsrape_max,
   rice_pro_max, tece_max
   trce_max, maiz_max
   /

   rotamin30(rota30) rotational minimum rules
   /biomass_min, legumes_min, minor_min, cereals_min/

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

  rota_kcr30(rota30, kcr) Mapping of crop types into crop rotation types
       / all1_max       . (tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, cottn_pro, begr, betr)
         all2_max       . (tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
           oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
           foddr, cottn_pro, begr, betr)
         cereals1_max   . (tece, maiz, trce, rice_pro)
         cereals2_max   . (tece, maiz, trce, rice_pro)
         resistant_max  . (begr,betr,foddr,sugr_cane,cottn_pro,oilpalm,others)
         oilcrops_max   . (sunflower, rapeseed)
         legumes_max . (foddr,puls_pro, soybean, groundnut)
         rootsrape_max . (sugr_beet, cassav_sp, potato, rapeseed)
         rice_pro_max . (rice_pro)
         tece_max . (tece)
         trce_max . (trce)
         maiz_max . (maiz)
         biomass_min   . (sugr_cane, oilpalm, begr, betr)
         legumes_min    . (soybean, groundnut, puls_pro, foddr)
         minor_min . (sunflower, rapeseed, sugr_beet, cassav_sp, potato, others)
         cereals_min . (tece, maiz, trce, rice_pro)
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
