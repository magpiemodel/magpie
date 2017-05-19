*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

sets
   kst(kall) plant-based staple products in the sectoral version
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp/

   kfo(kall) all products in the sectoral version
   /
   tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp,
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish,
   others
   /

   knf(kall) non-food products in the sectoral version
   /
   oilpalm,cottn_pro,foddr, pasture, begr, betr,
   oilcakes,ethanol,distillers_grain,fibres,
   res_cereals, res_fibrous, res_nonfibrous
   /

   nutrition nutritition attributes
       /kcal, protein/


*** Scenarios
   food_scen15  scenarios
       / SSP1, SSP2, SSP3, SSP4, SSP5,
         SSP1_boundary, SSP2_boundary, SSP3_boundary,
         SSP4_boundary, SSP5_boundary,
         a1, a2, b1, b2,
         SSP2_lowcal, SSP2_lowls, SSP2_waste,
         ssp2_high_yvonne,ssp2_low_yvonne,ssp2_lowest_yvonne,
         history /

   pop_scen15  scenarios
       / pop_SSP1, pop_SSP2, pop_SSP3, pop_SSP4, pop_SSP5,
         pop_a1, pop_a2, pop_b1, pop_b2 /

   gdp_scen15  scenarios
       / gdp_SSP1, gdp_SSP2, gdp_SSP3, gdp_SSP4, gdp_SSP5,
         gdp_a1, gdp_a2, gdp_b1, gdp_b2 /

;