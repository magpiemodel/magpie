*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

  landcover44 land cover classes used in bii calculation
    / crop_ann, crop_per, crop_tree, crop_fallow, manpast, rangeland, urban, aff_ndc, aff_co2p, primforest, secdforest, other, plant /

  bii_class44 bii coefficent land cover classes
    / crop_ann, crop_per, manpast, rangeland, urban, primary, secd_mature, secd_young, timber /

  bii_class_secd(bii_class44) bii coefficent land cover classes secondary vegetation
    / secd_mature, secd_young /

  ac_to_bii_class_secd(ac,bii_class_secd) Mapping between forest ageclasses and bii coefficent land cover classes 
  / (ac0,ac5,ac10,ac15,ac20,ac25,ac30)    . (secd_young)
    (ac35,ac40,ac45,ac50,ac55,ac60,
       ac65,ac70,ac75,ac80,ac85,ac90,
     ac95,ac100,ac105,ac110,ac115,
     ac120,ac125,ac130,ac135,ac140,
     ac145,ac150,ac155,acx)         . (secd_mature) /
  
;
