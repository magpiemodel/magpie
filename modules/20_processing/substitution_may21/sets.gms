*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

kpr(kall) Products that can be processed
   /tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,oilpalm,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro,brans,begr,betr,foddr,
   sugar,molasses,oils,oilcakes/

knpr(kall) Products that cannot be processed
   /alcohol,distillers_grain,ethanol,fibres,fish,livst_chick,livst_egg,livst_milk,
   livst_pig,livst_rum,oilcakes,pasture,puls_pro,res_cereals,res_fibrous,
   res_nonfibrous,scp,wood,woodfuel/

processing_subst20 Processing activities
/ milling, refining, extracting, distilling, fermentation, breeding, ginning, substitutes /

processing20(processing_subst20) Processing activities except substitution
/ milling, refining, extracting, distilling, fermentation, breeding, ginning /

kcereals20(kpr) Cereals used for processing
/tece,maiz,trce,rice_pro/

no_milling_ginning20(processing_subst20) Processing activities without milling and ginning
/refining, extracting, distilling, fermentation, breeding, substitutes /

oilcake_substitutes20(kpr) products that can be substituted for oilcakes
  /soybean,rapeseed,groundnut,sunflower,oilpalm,cottn_pro,oilcakes/

     scptype different types of scp
       /scp_methane,scp_sugar,scp_cellulose,scp_hydrogen/

     scen20 scenario of type of scp
      / mixed, methane, sugar, cellulose,hydrogen /

;
