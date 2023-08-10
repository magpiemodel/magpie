*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

   iter15 iterations between food demand model and magpie
   /iter1*iter10/
   curr_iter15(iter15)  currently active iteration
   prev_iter15(iter15)     last active iteration

   underaged15(age) Group of underaged age classes
   /0--4,5--9,10--14/

   adult15(age) Age groups for adult population
       /  15--19,
       20--24, 25--29, 30--34, 35--39,
       40--44, 45--49, 50--54, 55--59,
       60--64, 65--69, 70--74, 75--79
       80--84,85--89,90--94,95--99,100+ /

   working15(adult15) Group of working age population
   / 15--19,
     20--24, 25--29, 30--34, 35--39,
     40--44, 45--49, 50--54, 55--59/

   retired15(adult15) Age group of retired population
   /60--64, 65--69, 70--74, 75--79
       80--84,85--89,90--94,95--99,100+ /

   agegroup15 All age groups
   /underaged,working,retired /

   age2_adults15(agegroup15) Adult age group
   /working,retired /

   agegroup2age(agegroup15,age) Mapping between age cohort and age
   /
   underaged        . (0--4,5--9,10--14)
   working          . (15--19,
     20--24, 25--29, 30--34, 35--39,
     40--44, 45--49, 50--54, 55--59)
   retired          . (60--64, 65--69, 70--74, 75--79
       80--84,85--89,90--94,95--99,100+ )
   /

   bmi_tree15 Body mass index
   /low,lowsplit,mediumsplit,high,highsplit/

   bmi_group15 Body mass index gradient
   /verylow,low,medium,mediumhigh,high,veryhigh/

   bmi_group_est15(bmi_group15) Body mass index extremes
   /verylow,low,mediumhigh,high,veryhigh/

   age_new_estimated15(age) Estimated ages
   /0--4,5--9,10--14,15--19/

   reproductive(age) Age group of people in the reproductive age
   /20--24, 25--29, 30--34, 35--39/

   estimates15 Preliminary or final result for body height distribution
   /preliminary,final/

   paras_s15 Schofield equation parameters
   /slope, intercept/

   paras_b15 Intake equation parameters
   /saturation,halfsaturation,intercept/

   paras_h15 Bodyheight equation parameters
   /slope, exponent/

   kfo(kall) All products in the sectoral version
   / tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp,
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish,
   others /

   growth_food15(kfo) Food items that are important for body growth regression
   / soybean,groundnut,puls_pro,oils,
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish /

   kst(kfo) Plant-based staple products in the sectoral version
   / tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp /

   kfo_pp(kfo) Plant-based food products
   / tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,
   oils,sugar,molasses,alcohol,brans,scp,
   others /

   kfo_ap(kfo) Animal food products
   / livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish /

   kfo_lp(kfo) Livestock food products
   / livst_rum,livst_pig,livst_chick, livst_egg, livst_milk /

   kfo_st(kfo) Staple products
   / tece,maiz,trce,rice_pro,soybean,rapeseed,groundnut,sunflower,puls_pro,
   potato,cassav_sp,sugr_cane,sugr_beet,molasses,brans,scp /

   kfo_pf(kfo) Processed foods including oils sugar alcohol
   / oils,alcohol,sugar /

   kfo_ns(kfo) Food products that can be counted towards nuts and nuts_seeds
    / rapeseed, groundnut, sunflower /
** BENNI/ISABELLE: Where should groundnut be counted towards?

   kfo_norec(kfo) Food products that do not have an EAT-Lancet recommendation
    / sugr_cane, sugr_beet, molasses, alcohol, scp /
** Note: To Do: attribute sugr_cane, sugr_bee, molasses to sugar
* ISABELLE: What about brans?

   knf(kall) Non-food products in the sectoral version
   / oilpalm,cottn_pro,foddr, pasture, begr, betr,
   oilcakes,ethanol,distillers_grain,fibres,
   res_cereals, res_fibrous, res_nonfibrous,
   wood, woodfuel /

   nutrition Nutrition attributes
    / kcal, protein/

   par15 Parameters for food module
   / intercept,saturation,halfsaturation,non_saturation /
* intercept + saturation give the max value if non-saturation is 1
* halfsaturation is the gdp until which half of saturation is reached

 regr15  Demand regression types
      / overconsumption,livestockshare,processedshare,vegfruitshare /

*** Scenarios
   food_scen15  Food scenarios
       / SSP1, SSP2, SSP3, SSP4, SSP5,
         SSP1_boundary, SSP2_boundary, SSP3_boundary,
         SSP4_boundary, SSP5_boundary,
         SSP2_lowcal, SSP2_lowls, SSP2_waste,
         ssp2_high_yvonne,ssp2_low_yvonne,ssp2_lowest_yvonne,
         history /

   pop_scen15  Population scenarios
       / SSP1, SSP2, SSP3, SSP4, SSP5 /


  calibscen15  Calibration scenarios for balance flow
       / constant, fadeout2050 /

  livst_fadeoutscen15 Scenarios for changed composition of livestock products
       / halving2050, constant /

* The set kfo_rd can be defined in default.cfg and is used in the food substitution scenarios c15_rumdairy_scp_scen and c15_rumdairyscen
  kfo_rd(kfo) Ruminant meat and dairy food products
       / livst_rum,livst_milk /

  fadeoutscen15  Food substitution scenarios including functional forms with targets and transition periods
       / constant,
         lin_zero_10_50, lin_zero_20_50, lin_zero_20_30, lin_zero_20_70, lin_50pc_20_50, lin_50pc_20_50_extend65, lin_50pc_20_50_extend80,
         lin_50pc_10_50_extend90, lin_75pc_10_50_extend90, lin_80pc_20_50, lin_80pc_20_50_extend95, lin_90pc_20_50_extend95,
   lin_99-98-90pc_20_50-60-100, sigmoid_20pc_20_50, sigmoid_50pc_20_50, sigmoid_80pc_20_50 /

  t_scen15(t_all) Target years for transition to exogenous scenario diets
       / y2010, y2030, y2050 /

  kcal_scen15  Scenario of daily per capita calorie intake
       / 2100kcal, 2500kcal /

  EAT_scen15  Scenario of daily per capita calorie intake
       / BMK, FLX, PSC, VEG, VGN, FLX_hmilk, FLX_hredmeat /

  EAT_monogastrics15(kfo) monogastic products
      / livst_pig, livst_egg, livst_chick /
  EAT_ruminants15(kfo) ruminant products
      / livst_milk, livst_rum /
  EAT_fruitvegnutseed15(kfo) vegetables fruits nuts seeds
      / rapeseed, sunflower, others /
  EAT_pulses15(kfo) pulses
      / soybean, puls_pro, groundnut /
** BENNI: are groundnuts nuts or pulses?
** also note: peanuts (=groundnut?) has actually a single target (shouldn't we separate it?)
  EAT_sugar15(kfo) sugar
      / sugr_cane, sugr_beet, sugar, molasses /

  EAT_staples(kfo) All staple food products according to EAT Lancet definition
       / tece, maiz, trce, rice_pro, potato, cassav_sp /
*** ISABELLE/BENNI/MARCO: Should potato and cassav_sp be included in staples (balancing post?)
* Alternatively:
*EAT_starch(kfo) Food group starch as of EAT
*  / tece, maiz, trce, rice_pro /
  EAT_nonstaples(kfo) All non-staple food products according to EAT Lancet definition
       / soybean, rapeseed, groundnut, sunflower, puls_pro,
         sugr_cane, sugr_beet,
         oils, sugar, molasses, alcohol, brans, scp,
         livst_rum, livst_pig, livst_chick, livst_egg, livst_milk, fish,
         others /

* Food groups for Marco's diet model (my suggestion)
*  EAT_starch(kfo) Food group starch as of EAT   --> different from EAT_staples (see above)
*    / tece, maiz, trce, rice_pro /
*  EAT_soybeans(kfo) Soybeans as of EAT          --> not new set definition required
*    / soybean /
*  EAT_nutsseeds(kfo)  Food group of nuts and seeds as of EAT
*    / rapeseed, groundnut, sunflower /
**** BENNI: Is groundnut nuts or pulses?
*  EAT_legumes(kfo)    Legumes as of EAT
*    / puls_pro /
*  EAT_roots(kfo)      Food group of roots as of EAT
*    / potato, cassav_sp /
*  EAT_sugar15(kfo)    Sugar as of EAT           --> same as in above code, but different from Isabelle's
*    / sugr_cane, sugr_beet, sugar, molasses /
*  EAT_redmeat(kfo)    Food group of red meat as of EAT target
*    / livst_rum, livst_pig /
*  EAT_poultry(kfo)    EAT target food group poultry     ---> for 1:1 product, no extra set necessary
*    / livst_chick /
*  EAT_eggs(kfo)       EAT target food group eggs        ---> for 1:1 product, no extra set necessary
*    / livst_egg /
*  EAT_milk(kfo)       EAT target food group milk
*    / livst_milk /
*  EAT_fish(kfo)       EAT target food group fish
*    / fish /
*  EAT_fruits      --> common target for fruits and vegetables? (just add up?)
*  EAT_vegetables  --> common target for fruits and vegetables? (just add up?)
* For others: check how Isabelle solved this (separation of nuts from other (based on FAO))
* Where should oils, alcohol, brans, scp be attributed to?
* For oils (same problem!): just combine oil_palm and oil_veg to one target? (how did Isabelle solve this?)
* scp -> redmeat?
* for brans -> keep regression value?
* alcohol: 0 or default value (Lassen et al.)?


* Isabelle's code:
EAT_targettype15 Minimum or maximum target type of the EAT Lancet recommendations
    / min, max /

EAT_targets15 Food groups as well as individual foods for which EAT Lancet targets are defined
     / t_nutseeds, t_fruitveg,
       t_roots, t_redmeat,
       t_puls_pro, t_soybean, t_fish, t_livst_chick, t_livst_egg, t_livst_milk, t_sugar, t_oils /

EAT_mtargets15(EAT_targets15) EAT Lancet food targets where direct mapping to MAgPIE categories is possible
     / t_roots, t_redmeat,
       t_puls_pro, t_soybean, t_fish, t_livst_chick, t_livst_egg, t_livst_milk, t_sugar, t_oils /

EATtar_kfo15(EAT_mtargets15,kfo) Mapping between EAT Lancet food targets and MAgPIE categories
* ISABELLE: Where are groundnuts? (peanuts have separate target. should we add it?)
*
      / t_roots             . (potato, cassav_sp)
* Note: To Do: split roots target because cassav_sp contains bananas/plantains (see Marco's model: starchy fruits)
        t_redmeat           . (livst_rum, livst_pig)
        t_puls_pro          . (puls_pro)
        t_soybean           . (soybean)
        t_fish              . (fish)
        t_livst_chick       . (livst_chick)
        t_livst_egg         . (livst_egg)
        t_livst_milk        . (livst_milk)
        t_sugar             . (sugar)
* Note: To Do: add sugr_cane, sugr_beet, molasses
        t_oils              . (oils)
* Note: To Do: double check whether the oils target contains oil_palm and oil_veg
      /

;

alias(kst,kst2);
alias(bmi_group15,bmi_group15_2);
alias(kfo,kfo2);
alias(kfo_ap,kfo_ap2);
alias(kfo_st,kfo_st2);
alias(kfo_pf,kfo_pf2);
alias(kfo_ns,kfo_ns2);
alias(iso,iso2);
alias(reproductive,reproductive2);
alias(EAT_staples,EAT_staples2);
alias(EAT_mtargets15,EAT_mtargets15_2);
alias(EATtar_kfo15,EATtar_kfo15_2);
