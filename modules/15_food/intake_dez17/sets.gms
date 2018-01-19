*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets


   kfo(kall) all products in the sectoral version
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp,
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish,
   others
   /

   kst(kfo) plant-based staple products in the sectoral version
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp/


   kfo_ap(kfo)
   /
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish
   /

   kfo_st(kfo) staple products
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,molasses,brans,scp/

   kfo_pf(kfo) processed foods including oils sugar alcohol
   / oils,alcohol,sugar /

   knf(kall) non-food products in the sectoral version
   /
   oilpalm,cottn_pro,foddr, pasture, begr, betr,
   oilcakes,ethanol,distillers_grain,fibres,
   res_cereals, res_fibrous, res_nonfibrous,
   wood, woodfuel
   /

   nutrition nutritition attributes
   /kcal, protein/


*** Scenarios
   food_scen15  scenarios
       / SSP1, SSP2, SSP3, SSP4, SSP5,
         SSP1_boundary, SSP2_boundary, SSP3_boundary,
         SSP4_boundary, SSP5_boundary,
         SSP2_lowcal, SSP2_lowls, SSP2_waste,
         ssp2_high_yvonne,ssp2_low_yvonne,ssp2_lowest_yvonne,
         history /

   pop_scen15  population scenario for demographic structure
       / SSP1, SSP2, SSP3, SSP4, SSP5 /


  calibscen15  calibration scenarios for balanceflow
               / fadeout2050 /

  ruminantfadeoutscen15 scenarios for changed composition of livestock products
               / halving2050, constant /
;

alias(kst,kst2);
alias(kfo_ap,kfo_ap2);
alias(kfo_st,kfo_st2);
alias(kfo_pf,kfo_pf2);
alias(iso,iso2);
