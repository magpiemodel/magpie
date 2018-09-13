*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
  crp30  Crop rotation types
       / cereals_r, rice_r, cer_rice_r, fieldoil_r, soybean_r, rapeseed_r,
         sunflower_r, groundnut_r, oilpalm_r, puls_r, potato_r, cassava_r,
         roots_r, sugr_cane_r, sugr_beet_r, others_r, foddr_r, fiber_r,
         begr_r, betr_r /

  crpmax30(crp30) Maximum crop rotation
  crpmin30(crp30) Minimum crop rotation

  crp_kcr30(crp30,kcr) Mapping of crop types into crop rotation types
       / cereals_r   . (tece, maiz, trce)
         rice_r      . (rice_pro)
         cer_rice_r  . (tece, maiz, trce, rice_pro)
         fieldoil_r  . (soybean, rapeseed, groundnut, sunflower)
         soybean_r   . (soybean)
         rapeseed_r  . (rapeseed, sugr_beet)
         sunflower_r . (sunflower)
         groundnut_r . (groundnut)
         oilpalm_r   . (oilpalm)
         puls_r      . (puls_pro)
         potato_r    . (potato)
         cassava_r   . (cassav_sp)
         sugr_cane_r . (sugr_cane)
         sugr_beet_r . (sugr_beet)
         others_r    . (others)
         foddr_r     . (foddr)
         fiber_r     . (cottn_pro)
         begr_r      . (begr)
         betr_r      . (betr)  /
;
