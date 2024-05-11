*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  ltype14 calibration land types
       / crop, past /

  k(kall) Primary products
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, pasture, cottn_pro, begr, betr, livst_rum, livst_pig,
         livst_chick, livst_egg, livst_milk, fish, wood, woodfuel/

  kve(k) Land-use activities
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, pasture, cottn_pro, begr, betr /

  kcr(kve) Cropping activities
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, cottn_pro, begr, betr /

  knbe14(kcr) Cropping activities excluding bioenergy plants
       / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
         oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
         foddr, cottn_pro /

  ncp_type14 natures contributions to people (NCP) relevant for agricultural yields
       / soil_intact, poll_suff /

;

