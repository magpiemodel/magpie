*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets


kpr(kall) Products that can be processed
   /tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,oilpalm,
   potato,cassav_sp,sugr_cane,sugr_beet,others,cottn_pro,brans,begr,betr,foddr,
   sugar,molasses,oils/

knpr(kall) Products that cannot be processed
   /alcohol,distillers_grain,ethanol,fibres,fish,livst_chick,livst_egg,livst_milk,
   livst_pig,livst_rum,oilcakes,pasture,puls_pro,res_cereals,res_fibrous,
   res_nonfibrous,scp/

processing_subst20 Processing activities
/ milling, refining, extracting, distilling, fermentation, breeding, ginning, substitutes /

processing20(processing_subst20) Processing activities except substitution
/ milling, refining, extracting, distilling, fermentation, breeding, ginning /

kcereals20(kpr) Cereals used for processing
/tece,maiz,trce,rice_pro/

no_milling_ginning20(processing_subst20) Processing activities without milling and ginning
/refining, extracting, distilling, fermentation, breeding, substitutes /



;