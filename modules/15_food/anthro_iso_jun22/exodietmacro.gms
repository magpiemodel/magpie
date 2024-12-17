*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' as include statements are not allowed within the if statements, we execute
*' the if statement before, put the result in s15_run_diet_postprocessing,
*' and then execute the if statement again within the included file:
if (s15_run_diet_postprocessing = 1,

*' This macro is executed twice, once after the presolve and once in the
*' intersolve. It calibrates the values, includes exogenous diet modifications
*' in the postprocessing and aggregates to regional level.

* saving regression outcome for per capita food demand for different foods
  p15_kcal_regr(t, iso, kfo) = v15_kcal_regr.l(iso, kfo);

*' The calibration factor is added to the regression value.
   p15_kcal_pc_iso(t,iso,kfo) =
          v15_kcal_regr.l(iso,kfo) + p15_kcal_calib(t,iso,kfo) * s15_calibrate;

*' Negative values that can possibly occur due to calibration are set to zero.
   p15_kcal_pc_iso(t,iso,kfo)$(p15_kcal_pc_iso(t,iso,kfo) < 0) = 0;

* saving regression outcome for BMI shares
  p15_bmi_shr_regr(t,iso,sex,age,bmi_group15) = v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);

  p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) =
          p15_bmi_shr_regr(t,iso,sex,age,bmi_group15) + i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) * s15_calibrate;

* The BMI shares are not allowed to exceed the bounds 0 and 1. Values are corrected to the bounds.
  p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)$(p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)<0) = 0;
  p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)$(p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)>1) = 1;
* The mismatch is balanced by moving the exceeding quantities into the middle BMI group.
  p15_bmi_shr_calibrated(t,iso,sex,age,"medium")=
      1 - (sum(bmi_group15, p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15))
      - p15_bmi_shr_calibrated(t,iso,sex,age,"medium"));



*###############################################################################
* ###### Food substitution scenarios

* Substitution of ruminant beef with poultry:
  p15_kcal_pc_iso_orig(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
  p15_kcal_pc_iso(t,iso,"livst_rum") =
                 p15_kcal_pc_iso_orig(t,iso,"livst_rum") * i15_ruminant_fadeout(t,iso);
  p15_kcal_pc_iso(t,iso,"livst_chick") = p15_kcal_pc_iso_orig(t,iso,"livst_chick")
               + p15_kcal_pc_iso_orig(t,iso,"livst_rum") * (1- i15_ruminant_fadeout(t,iso));


* Substitution of fish with poultry:
  p15_kcal_pc_iso_orig(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
  p15_kcal_pc_iso(t,iso,"fish") =
                 p15_kcal_pc_iso_orig(t,iso,"fish") * i15_fish_fadeout(t,iso);
  p15_kcal_pc_iso(t,iso,"livst_chick") = p15_kcal_pc_iso_orig(t,iso,"livst_chick")
               + p15_kcal_pc_iso_orig(t,iso,"fish") * (1-i15_fish_fadeout(t,iso));


* Fade-out of alcohol consumption without substitution:
* (leads to inconsistencies with BMI estimates)
  p15_kcal_pc_iso_orig(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
  p15_kcal_pc_iso(t,iso,"alcohol") =
                 p15_kcal_pc_iso_orig(t,iso,"alcohol") * i15_alcohol_fadeout(t,iso);


* Substitution of livestock products (without fish) with plant-based food commodities:
  p15_kcal_pc_iso_orig(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
  p15_kcal_pc_iso_livestock_orig(t,iso) = sum(kfo_lp,p15_kcal_pc_iso(t,iso,kfo_lp));
  p15_kcal_pc_iso_plant_orig(t,iso) = sum(kfo_pp,p15_kcal_pc_iso(t,iso,kfo_pp));

  p15_livestock_kcal_structure_orig(t,iso,kfo_lp)$(p15_kcal_pc_iso_livestock_orig(t,iso)>0) =
                                 p15_kcal_pc_iso(t,iso,kfo_lp)
                                 /p15_kcal_pc_iso_livestock_orig(t,iso);

  p15_plant_kcal_structure_orig(t,iso,kfo_pp)$(p15_kcal_pc_iso_plant_orig(t,iso)>0) =
                                 p15_kcal_pc_iso(t,iso,kfo_pp)
                                 /p15_kcal_pc_iso_plant_orig(t,iso);

  p15_kcal_pc_iso(t,iso,kfo_lp) = p15_livestock_kcal_structure_orig(t,iso,kfo_lp)
                 *p15_kcal_pc_iso_livestock_orig(t,iso)*i15_livestock_fadeout(t,iso);
  p15_kcal_pc_iso(t,iso,kfo_pp) = p15_plant_kcal_structure_orig(t,iso,kfo_pp)
                 *(p15_kcal_pc_iso_plant_orig(t,iso)
                 + p15_kcal_pc_iso_livestock_orig(t,iso) * (1-i15_livestock_fadeout(t,iso)));


* Substitution of ruminant meat and dairy products with plant-based food commodities:
  p15_kcal_pc_iso_orig(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
  p15_kcal_pc_iso_rumdairy_orig(t,iso) = sum(kfo_rd,p15_kcal_pc_iso(t,iso,kfo_rd));
  p15_kcal_pc_iso_plant_orig(t,iso) = sum(kfo_pp,p15_kcal_pc_iso(t,iso,kfo_pp));

  p15_rumdairy_kcal_structure_orig(t,iso,kfo_rd)$(p15_kcal_pc_iso_rumdairy_orig(t,iso)>0) =
                                 p15_kcal_pc_iso(t,iso,kfo_rd)
                                 /p15_kcal_pc_iso_rumdairy_orig(t,iso);

  p15_plant_kcal_structure_orig(t,iso,kfo_pp)$(p15_kcal_pc_iso_plant_orig(t,iso)>0) =
                                 p15_kcal_pc_iso(t,iso,kfo_pp)
                                 /p15_kcal_pc_iso_plant_orig(t,iso);

  p15_kcal_pc_iso(t,iso,kfo_rd) = p15_rumdairy_kcal_structure_orig(t,iso,kfo_rd)
                 *p15_kcal_pc_iso_rumdairy_orig(t,iso)*i15_rumdairy_fadeout(t,iso);
  p15_kcal_pc_iso(t,iso,kfo_pp) = p15_plant_kcal_structure_orig(t,iso,kfo_pp)
                 *(p15_kcal_pc_iso_plant_orig(t,iso)
                 + p15_kcal_pc_iso_rumdairy_orig(t,iso) * (1- i15_rumdairy_fadeout(t,iso)));

*' @code
*' Substitution of ruminant meat and dairy products (kfo_rd) with single-cell protein (SCP) based on protein/cap/day:
*'
*' Before the substitution, kfo_rd is converted from kcal/cap/day to g protein/cap/day using i15_protein_to_kcal_ratio(t,kfo_rd).
*' After the substitution of kfo_rd with SCP (1-i15_rumdairy_scp_fadeout), SCP is converted 
*' back to kcal/cap/day using i15_protein_to_kcal_ratio(t,"scp").
*'
*' Protein to kcal ratio:
i15_protein_to_kcal_ratio(t,kfo) = fm_nutrition_attributes(t,kfo,"protein") / fm_nutrition_attributes(t,kfo,"kcal");
*'
*' Increase of single-cell protein (SCP):
p15_protein_pc_iso_scp(t,iso,kfo_rd) = p15_kcal_pc_iso(t,iso,kfo_rd) * (1-i15_rumdairy_scp_fadeout(t,iso)) * i15_protein_to_kcal_ratio(t,kfo_rd);
p15_kcal_pc_iso(t,iso,"scp") = p15_kcal_pc_iso(t,iso,"scp") + sum(kfo_rd, p15_protein_pc_iso_scp(t,iso,kfo_rd)) / i15_protein_to_kcal_ratio(t,"scp");
*'
*' Reduction of ruminant meat and dairy products (kfo_rd):
p15_kcal_pc_iso(t,iso,kfo_rd) = p15_kcal_pc_iso(t,iso,kfo_rd) * i15_rumdairy_scp_fadeout(t,iso);
*'
*' Plant oil and sugar demands as ingredients for animal-free milk alternative production using single cell protein 
*' are calculated based on the ratio of fat or sugar to protein in cow milk. 
*' This ratio is typically reported on a mass basis, but the ratio is converted here to be based on caloric content. 
*' Cow milk content is chosen as the dominant source of milk produced globally.
*' Data sources: @muehlhoff_milk_2013 and @fao_food_2004
*'
p15_kcal_pc_iso(t,iso,"oils") = p15_kcal_pc_iso(t,iso,"oils") 
   + sum(kfo_rd$sameas(kfo_rd,"livst_milk"), p15_protein_pc_iso_scp(t,iso,kfo_rd)) / 
     s15_scp_protein_per_milk * s15_scp_fat_per_milk * fm_nutrition_attributes(t,"oils", "kcal");
*'
p15_kcal_pc_iso(t,iso,"sugar") = p15_kcal_pc_iso(t,iso,"sugar") 
   + sum(kfo_rd$sameas(kfo_rd,"livst_milk"), p15_protein_pc_iso_scp(t,iso,kfo_rd)) / 
     s15_scp_protein_per_milk * s15_scp_sugar_per_milk * fm_nutrition_attributes(t, "sugar" ,"kcal");
*' 
*' The ratio of fat to protein in raw microbial biomass (used as single cell protein) is much lower than for 
*' plant based meat alternatives and animal based meat products. If the desired microbial product is alternative meat, 
*' this may require supplementation with plant based fats to more closely match other existing products. 
*' It is therefore possible to choose whether microbial biomass should be supplemented with plant based oil, 
*' which drives additional demand for plant based oil production in MAgPIE. 
*' For alternative microbial meats supplemented with fat, the desired fat to protein ratio is given 
*' as 2:3 on a mass basis, analogous to similar products. Because microbial biomass already contains some fats, 
*' the additional amount of plant based fat needed is given as the difference between the amount of fat present 
*' in microbial biomass and the amount of fat needed to reach the desired protein to fat ratio. 
*' Unlike additional plant oil and sugar demand for microbial milk, the additional amount of plant fat needed 
*' for microbial meat is calculated dynamically based on the protein content of microbial biomass. 
*' This is because the microbial protein content varies depending on the specific type of microbes used 
*' (e.g. bacteria or funghi), whereas the nutritional content of cow milk is assumed to be fixed. 
*' If the microbial protein is therefore changed, the amount of fat must also change to keep the same 
*' fat to protein ratio. It is also assumed, unlike for microbial milk, that additional carbohydrates 
*' (e.g., sugar) are not required for alternative microbial meats. This is because meat products contain 
*' very little or no carbohydrates. 
*' Data sources: @mazac_novelfoods_2023 and @jarvio_LCA_MP_2021
*' 
p15_kcal_pc_iso(t,iso,"oils")$(s15_scp_supplement_fat_meat = 1) = p15_kcal_pc_iso(t,iso,"oils") 
   + sum(kfo_rd$sameas(kfo_rd,"livst_rum"), p15_protein_pc_iso_scp(t,iso,kfo_rd)) / 
     fm_nutrition_attributes(t,"scp", "protein") * (fm_nutrition_attributes(t,"scp", "protein") * 
     s15_scp_fat_protein_ratio_meat - s15_scp_fat_content) * fm_nutrition_attributes(t,"oils", "kcal");
*' 
*' @stop

* Conditional reduction of livestock products (without fish) depending on s15_kcal_pc_livestock_supply_target.
* Optional substitution with plant-based products depending on s15_livescen_target_subst.
  p15_kcal_pc_iso_orig(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
  p15_kcal_pc_iso_livestock_orig(t,iso) = sum(kfo_lp,p15_kcal_pc_iso(t,iso,kfo_lp));
  p15_kcal_pc_iso_plant_orig(t,iso) = sum(kfo_pp,p15_kcal_pc_iso(t,iso,kfo_pp));

  p15_livestock_kcal_structure_orig(t,iso,kfo_lp)$(p15_kcal_pc_iso_livestock_orig(t,iso)>0) =
                                 p15_kcal_pc_iso(t,iso,kfo_lp)
                                 /p15_kcal_pc_iso_livestock_orig(t,iso);

  p15_plant_kcal_structure_orig(t,iso,kfo_pp)$(p15_kcal_pc_iso_plant_orig(t,iso)>0) =
                                 p15_kcal_pc_iso(t,iso,kfo_pp)
                                 /p15_kcal_pc_iso_plant_orig(t,iso);

  p15_kcal_pc_livestock_supply_target(iso) = s15_kcal_pc_livestock_supply_target * f15_overcons_FAOwaste(iso,"livst_rum");

  loop(iso$(p15_kcal_pc_iso_livestock_orig(t,iso) > p15_kcal_pc_livestock_supply_target(iso)),
  p15_kcal_pc_iso(t,iso,kfo_lp) = p15_livestock_kcal_structure_orig(t,iso,kfo_lp)
                 * (p15_kcal_pc_livestock_supply_target(iso)*(1-i15_livestock_fadeout_threshold(t,iso))
                 + p15_kcal_pc_iso_livestock_orig(t,iso)*i15_livestock_fadeout_threshold(t,iso));
  p15_kcal_pc_iso(t,iso,kfo_pp) = p15_plant_kcal_structure_orig(t,iso,kfo_pp)
          * (p15_kcal_pc_iso_plant_orig(t,iso)
            + (p15_kcal_pc_iso_livestock_orig(t,iso) -
            sum(kfo_lp, p15_kcal_pc_iso(t,iso,kfo_lp))) * s15_livescen_target_subst);
  );


*###############################################################################
* ######  WASTE CALCULATIONS (required for exogenous food waste or diet scenarios)

* The ratio of food demand at household level to food intake is determined
* by the amount of food that is wasted. This ratio is one of the drivers of
* future food demand trajetories.
* For the calculation of the ratio between food demand and intake, total food
* calorie intake based on CALIBRATED parameters needs to be calculated:

  p15_intake_total(t,iso)$(sum((sex,age), im_demography(t,iso,sex,age)) >0 ) =
       (sum((sex, age, bmi_group15), p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)*
       im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
       + i15_kcal_pregnancy(t,iso))
       / sum((sex,age), im_demography(t,iso,sex,age));

  p15_demand2intake_ratio(t,iso) = 1$(p15_intake_total(t,iso) = 0) +
         (sum(kfo,p15_kcal_pc_iso(t,iso,kfo)) / p15_intake_total(t,iso))$(
           p15_intake_total(t,iso) <> 0);


* Next, we derive a product-specific waste share, which uses product specific
* waste shares from FAO and calibrates them to meet total
* food waste ratio.
* To achieve maximum consistency, this calibration involves three steps.

* First, FAO waste factors are applied and then intake is proportionally rescaled to meet total intake
* This distributes the differences in waste estimates rather equally over different products
  p15_intake_detail(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) / f15_overcons_FAOwaste(iso,kfo);

  p15_intake_detail(t,iso,kfo)$(sum(kfo2, p15_intake_detail(t,iso,kfo2))<>0) =
                    p15_intake_detail(t,iso,kfo) / sum(kfo2, p15_intake_detail(t,iso,kfo2)) *
                    p15_intake_total(t,iso);

* To avoid negative waste, we reduce intake where it exceed food availabiltiy
  p15_intake_detail(t,iso,kfo)$(p15_intake_detail(t,iso,kfo)>p15_kcal_pc_iso(t,iso,kfo)) =
                  p15_kcal_pc_iso(t,iso,kfo);

* In a second round of calibration, we rescale food waste to meet total food waste.
* Now, waste is increasing only where there is already waste.
   p15_waste_pc(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_intake_detail(t,iso,kfo);

   p15_waste_pc(t,iso,kfo) = 0$(sum(kfo2, p15_waste_pc(t,iso,kfo2))=0) + (
                    p15_waste_pc(t,iso,kfo) / sum(kfo2, p15_waste_pc(t,iso,kfo2))*
                    (p15_intake_total(t,iso)*p15_demand2intake_ratio(t,iso)-p15_intake_total(t,iso))
                    )$(sum(kfo2, p15_waste_pc(t,iso,kfo2))<>0);

   p15_intake_detail(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_waste_pc(t,iso,kfo);


* The third calibration is only needed for those countries where total intake exceeds calory availabtility.
* Here we want to have the inconsistency in the waste, not in the intake.
   p15_intake_detail(t,iso,kfo)$(sum(kfo2, p15_intake_detail(t,iso,kfo2))<>0) =
                     p15_intake_detail(t,iso,kfo) / sum(kfo2, p15_intake_detail(t,iso,kfo2))*
                     p15_intake_total(t,iso);
   p15_waste_pc(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_intake_detail(t,iso,kfo);

* We calculate a product specific demand2intake ratio
   p15_demand2intake_ratio_detail(t,iso,kfo)=1$(p15_intake_detail(t,iso,kfo) = 0) +
            (p15_kcal_pc_iso(t,iso,kfo) / p15_intake_detail(t,iso,kfo))$(p15_intake_detail(t,iso,kfo) > 0);

* Bodyheight is estimated based on a calorie availabiltiy regression, including
* waste. As food waste scenarios should not affect bodyheight, we apply the
* normal food waste ratios for the growth estimates
  p15_demand2intake_ratio_detail_preexo(t,iso,kfo)=p15_demand2intake_ratio_detail(t,iso,kfo);

* ###### Exogenous EAT Lancet diet scenario

*' @code
*' Transition to exogenous Planetary Health diet (PHD) scenarios [@willett_food_2019]:
*' It is possible to define exogenous diet scenarios that replace the regression-based
*' calculation of food intake and demand scenario-dependent targets following the
*' exogenous PHDs, India-specific recommendations or model-internal intake estimates
*' that hit the PHD targets by setting the switch `s15_exo_diet` to 1, 2 or 3.

if (s15_exo_diet > 0,

*' 1.) In a first step, the exogenous scenario diets are defined by selecting a
*' scenario target for total daily per capita food intake
$ifthen "%c15_kcal_scen%" == "healthy_BMI"

  p15_bmi_shr_target(t,iso,sex,age,bmi_group15)=0;
  p15_bmi_shr_target(t,iso,sex,age,"medium")=1;

  i15_intake_scen_target(t,iso)$(sum((sex,age), im_demography(t,iso,sex,age)) >0 ) =
     (sum((sex, age, bmi_group15), p15_bmi_shr_target(t,iso,sex,age,bmi_group15)*
     im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
     + i15_kcal_pregnancy(t,iso))
     / sum((sex,age), im_demography(t,iso,sex,age));

$elseif "%c15_kcal_scen%" == "no_underweight"

  p15_bmi_shr_target(t,iso,sex,age,bmi_group15)=p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15);
  p15_bmi_shr_target(t,iso,sex,age,"medium")=
            p15_bmi_shr_calibrated(t,iso,sex,age,"verylow")
            + p15_bmi_shr_calibrated(t,iso,sex,age,"low")
            + p15_bmi_shr_calibrated(t,iso,sex,age,"medium");
  p15_bmi_shr_target(t,iso,sex,age,"verylow")=0;
  p15_bmi_shr_target(t,iso,sex,age,"low")=0;

  i15_intake_scen_target(t,iso)$(sum((sex,age), im_demography(t,iso,sex,age)) >0 ) =
     (sum((sex, age, bmi_group15), p15_bmi_shr_target(t,iso,sex,age,bmi_group15)*
     im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
     + i15_kcal_pregnancy(t,iso))
     / sum((sex,age), im_demography(t,iso,sex,age));

$elseif "%c15_kcal_scen%" == "no_overweight"

  p15_bmi_shr_target(t,iso,sex,age,bmi_group15)=p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15);
  p15_bmi_shr_target(t,iso,sex,age,"medium")=
            p15_bmi_shr_calibrated(t,iso,sex,age,"mediumhigh")
            + p15_bmi_shr_calibrated(t,iso,sex,age,"high")
            + p15_bmi_shr_calibrated(t,iso,sex,age,"veryhigh")
            + p15_bmi_shr_calibrated(t,iso,sex,age,"medium");
  p15_bmi_shr_target(t,iso,sex,age,"mediumhigh")=0;
  p15_bmi_shr_target(t,iso,sex,age,"high")=0;
  p15_bmi_shr_target(t,iso,sex,age,"veryhigh")=0;
  i15_intake_scen_target(t,iso)$(sum((sex,age), im_demography(t,iso,sex,age)) >0 ) =
     (sum((sex, age, bmi_group15), p15_bmi_shr_target(t,iso,sex,age,bmi_group15)*
     im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
     + i15_kcal_pregnancy(t,iso))
     / sum((sex,age), im_demography(t,iso,sex,age));

$elseif "%c15_kcal_scen%" == "half_overweight"
          p15_bmi_shr_target(t,iso,sex,age,bmi_group15)=p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15);
          p15_bmi_shr_target(t,iso,sex,age,"medium")=
                    p15_bmi_shr_calibrated(t,iso,sex,age,"mediumhigh")/2
                    + p15_bmi_shr_calibrated(t,iso,sex,age,"high")/2
                    + p15_bmi_shr_calibrated(t,iso,sex,age,"veryhigh")/2
                    + p15_bmi_shr_calibrated(t,iso,sex,age,"medium");
          p15_bmi_shr_target(t,iso,sex,age,"mediumhigh")=p15_bmi_shr_calibrated(t,iso,sex,age,"mediumhigh")/2;
          p15_bmi_shr_target(t,iso,sex,age,"high")=p15_bmi_shr_calibrated(t,iso,sex,age,"high")/2;
          p15_bmi_shr_target(t,iso,sex,age,"veryhigh")=p15_bmi_shr_calibrated(t,iso,sex,age,"veryhigh")/2;
          i15_intake_scen_target(t,iso)$(sum((sex,age), im_demography(t,iso,sex,age)) >0 ) =
             (sum((sex, age, bmi_group15), p15_bmi_shr_target(t,iso,sex,age,bmi_group15)*
             im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
             + i15_kcal_pregnancy(t,iso))
             / sum((sex,age), im_demography(t,iso,sex,age));

$elseif "%c15_kcal_scen%" == "no_underweight_half_overweight"
     p15_bmi_shr_target(t,iso,sex,age,bmi_group15)=p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15);
     p15_bmi_shr_target(t,iso,sex,age,"medium") =
              p15_bmi_shr_calibrated(t,iso,sex,age,"verylow")
               + p15_bmi_shr_calibrated(t,iso,sex,age,"low")
               + p15_bmi_shr_calibrated(t,iso,sex,age,"mediumhigh")/2
               + p15_bmi_shr_calibrated(t,iso,sex,age,"high")/2
               + p15_bmi_shr_calibrated(t,iso,sex,age,"veryhigh")/2
               + p15_bmi_shr_calibrated(t,iso,sex,age,"medium");
     p15_bmi_shr_target(t,iso,sex,age,"verylow")=0;
     p15_bmi_shr_target(t,iso,sex,age,"low")=0;
     p15_bmi_shr_target(t,iso,sex,age,"mediumhigh")=p15_bmi_shr_calibrated(t,iso,sex,age,"mediumhigh")/2;
     p15_bmi_shr_target(t,iso,sex,age,"high")=p15_bmi_shr_calibrated(t,iso,sex,age,"high")/2;
     p15_bmi_shr_target(t,iso,sex,age,"veryhigh")=p15_bmi_shr_calibrated(t,iso,sex,age,"veryhigh")/2;
     i15_intake_scen_target(t,iso)$(sum((sex,age), im_demography(t,iso,sex,age)) >0 ) =
        (sum((sex, age, bmi_group15), p15_bmi_shr_target(t,iso,sex,age,bmi_group15)*
        im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
        + i15_kcal_pregnancy(t,iso))
        / sum((sex,age), im_demography(t,iso,sex,age));

$elseif "%c15_kcal_scen%" == "endo"
  i15_intake_scen_target(t,iso) = p15_intake_total(t,iso);
  p15_bmi_shr_target(t,iso,sex,age,bmi_group15) = p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15);

$else
  i15_intake_scen_target(t,iso) = sum(kfo,i15_intake_EATLancet_all(iso,"%c15_kcal_scen%","%c15_EAT_scen%",kfo));
  p15_bmi_shr_target(t,iso,sex,age,bmi_group15) = 0;
  p15_bmi_shr_target(t,iso,sex,age,"medium") = 1;
$endif

*' The intake target is adjusted to meet the calorie target
  p15_intake_detailed_scen_target(t,iso,kfo)$(p15_intake_total(t,iso) > 0) =
    p15_intake_detail(t,iso,kfo) / p15_intake_total(t,iso) * i15_intake_scen_target(t,iso);

  p15_intake_detailed_scen_target(t,iso,kfo)$(p15_intake_total(t,iso) = 0) = 0;

*' 2.) The second step defines the daily per capita intake of different food
*' commodities.

*----------------------------------------------------------------------------------------
if ((s15_exo_diet = 1 or s15_exo_diet = 2),
*' In case of diet scenarios that are parametrized to a food-specific data set published
*' by the EAT-Lancet Commission (`s15_exo_diet=1`), this calculation step consists of
*' filling up the scenario target for total daily per capita food intake according
*' to the food-specific calorie intake of non-staple crops of this data set based on
*' exogenous food demand projections.
*' In case that the in step 1.) selected total calorie intake is not equal to total intake
*' of the data set, only the calories for staple crops are modified and calories for
*' non-staple food commodities are preserved.

*' The EAT lancet target values are the same for non-staples irrespective of the calorie target
*' Only non-staples differ
    i15_intake_EATLancet(iso,kfo) =
          i15_intake_EATLancet_all(iso,"2100kcal","%c15_EAT_scen%",kfo);

*' upper bound for monogastric meat and eggs
    if (s15_exo_monogastric=1,
      p15_intake_detailed_scen_target(t,iso,EAT_monogastrics15)$(p15_intake_detailed_scen_target(t,iso,EAT_monogastrics15) > i15_intake_EATLancet(iso,EAT_monogastrics15))
        = i15_intake_EATLancet(iso,EAT_monogastrics15));
*' upper bound for ruminant products
    if (s15_exo_ruminant=1,
      p15_intake_detailed_scen_target(t,iso,EAT_ruminants15)$(p15_intake_detailed_scen_target(t,iso,EAT_ruminants15) > i15_intake_EATLancet(iso,EAT_ruminants15))
        = i15_intake_EATLancet(iso,EAT_ruminants15));
*' target value for fish
    if (s15_exo_fish=1,
        p15_intake_detailed_scen_target(t,iso,"fish") = i15_intake_EATLancet(iso,"fish"));
*' lower bound for fruits, veggies, nuts and seeds
    if (s15_exo_fruitvegnut=1,
      p15_intake_detailed_scen_target(t,iso,EAT_fruitvegnutseed15)$(p15_intake_detailed_scen_target(t,iso,EAT_fruitvegnutseed15) < i15_intake_EATLancet(iso,EAT_fruitvegnutseed15))
      = i15_intake_EATLancet(iso,EAT_fruitvegnutseed15));
*' lower bound for pulses
    if (s15_exo_pulses=1,
      p15_intake_detailed_scen_target(t,iso,EAT_pulses15_old)$(p15_intake_detailed_scen_target(t,iso,EAT_pulses15_old) < i15_intake_EATLancet(iso,EAT_pulses15_old))
      = i15_intake_EATLancet(iso,EAT_pulses15_old));
*' upper bound for sugar
    if (s15_exo_sugar=1,
      p15_intake_detailed_scen_target(t,iso,EAT_sugar15)$(p15_intake_detailed_scen_target(t,iso,EAT_sugar15) > i15_intake_EATLancet(iso,EAT_sugar15))
        = i15_intake_EATLancet(iso,EAT_sugar15));
*' target value for oils
    if (s15_exo_oils=1,
      p15_intake_detailed_scen_target(t,iso,"oils") = i15_intake_EATLancet(iso,"oils"));
*' target value for brans
    if (s15_exo_brans=1,
      p15_intake_detailed_scen_target(t,iso,"brans") = i15_intake_EATLancet(iso,"brans"));
*' target value for single cell protein
    if (s15_exo_scp=1,
      p15_intake_detailed_scen_target(t,iso,"scp") = i15_intake_EATLancet(iso,"scp"));
*' upper bound for alcohol
* alcohol target is not part of EAT Lancet recommendation. Upper boundary is therefore included as specific switch s15_alc_scen
    if (s15_exo_alcohol=1,
      p15_intake_detailed_scen_target(t,iso,"alcohol")$(p15_intake_detailed_scen_target(t,iso,"alcohol") > s15_alc_scen*i15_intake_scen_target(t,iso))
        = s15_alc_scen*i15_intake_scen_target(t,iso);
    );

    p15_intake_detailed_scen_target(t,iso,EAT_staples_old)$(sum(EAT_staples2_old, i15_intake_EATLancet(iso,EAT_staples2_old)) > 0) =
            (i15_intake_scen_target(t,iso) - sum(EAT_nonstaples2_old, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2_old))) *
            (i15_intake_EATLancet(iso,EAT_staples_old) / sum(EAT_staples2_old, i15_intake_EATLancet(iso,EAT_staples2_old)))
            ;

* Correction where calorie balancing would lead to negative p15_intake_detailed_scen_target values
    p15_intake_detailed_scen_target(t,iso,EAT_staples_old)$(i15_intake_scen_target(t,iso) - sum(EAT_nonstaples2_old, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2_old)) < 0) =
                    0;
    p15_intake_detailed_scen_target(t,iso,EAT_nonstaples_old)$(i15_intake_scen_target(t,iso) - sum(EAT_nonstaples2_old, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2_old)) < 0) =
             i15_intake_scen_target(t,iso) * p15_intake_detailed_scen_target(t,iso,EAT_nonstaples_old) / sum(EAT_nonstaples2_old, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2_old))
                    ;

    if (smin((iso,kfo), p15_intake_detailed_scen_target(t,iso,kfo)) < (-1e-10),
       abort "The parameter p15_intake_detailed_scen_target became negative after calorie balancing.";
    );

*----------------------------------------------------------------------------------------
elseif s15_exo_diet = 3,
*' In case of a MAgPIE-specific realization of the EAT Lancet diet (`s15_exo_diet=3`),
*' model-internal diet projections are constrained by recommended ranges for intake
*' (`f15_rec_EATLancet`) of different food groups to ensure healthy and sustainable
*' diets according to the EAT-Lancet Commission. After all calorie recommendations
*' for non-staple food groups are satisfied, intake of staple crops is modified such
*' that the in step 1.) selected total calorie intake is met.
* Note: brans is the only food commodity group that will not be affected
*       by the following calculations.

* For cases where the intake in a EAT-Lancet food group is zero for a country
* in a particular time step, a small amount is added to ensure no division by
* zero. This way, all kfo-items in the respective food group are corrected by
* the same amount.
  p15_intake_detail(t,iso,kfo)$(sum(EATtar_kfo15(EAT_mtargets15_2,kfo),
                                   sum(EATtar_kfo15_2(EAT_mtargets15_2,kfo2), p15_intake_detail(t,iso,kfo2))) = 0) =
                                   p15_intake_detail(t,iso,kfo) + 1e-6;

*' The single targets can be set manually via switches
*' (e.g., s15_exo_ruminant, s15_exo_fish, etc.).

*' upper bound for monogastric products
    if (s15_exo_monogastric = 1,
* upper bound for eggs
      p15_intake_detailed_scen_target(t,iso,"livst_egg")$(p15_intake_detail(t,iso,"livst_egg")
                                                               > f15_rec_EATLancet(iso,"t_livst_egg","max")
                                                            ) =
             f15_rec_EATLancet(iso,"t_livst_egg","max");
* upper bound for chicken
      p15_intake_detailed_scen_target(t,iso,"livst_chick")$(p15_intake_detail(t,iso,"livst_chick")
                                                             > f15_rec_EATLancet(iso,"t_livst_chick","max")
                                                          ) =
           f15_rec_EATLancet(iso,"t_livst_chick","max");
* upper bound for redmeat (share of pigs in redmeat)
      p15_intake_detailed_scen_target(t,iso,"livst_pig")$(sum(EAT_redmeat15_2, p15_intake_detail(t,iso,EAT_redmeat15_2))
                                                              > f15_rec_EATLancet(iso,"t_redmeat","max")
                                                           ) =
            (p15_intake_detail(t,iso,"livst_pig") / sum(EAT_redmeat15_2, p15_intake_detail(t,iso,EAT_redmeat15_2)))
               * f15_rec_EATLancet(iso,"t_redmeat","max");
       );

*' upper bound for ruminant products
    if (s15_exo_ruminant = 1,
* upper bound for redmeat (pig and ruminant)
      p15_intake_detailed_scen_target(t,iso,"livst_rum")$(sum(EAT_redmeat15_2, p15_intake_detail(t,iso,EAT_redmeat15_2))
                                                               > f15_rec_EATLancet(iso,"t_redmeat","max")
                                                            ) =
             (p15_intake_detail(t,iso,"livst_rum") / sum(EAT_redmeat15_2, p15_intake_detail(t,iso,EAT_redmeat15_2)))
                * f15_rec_EATLancet(iso,"t_redmeat","max");
* upper bound for milk
      p15_intake_detailed_scen_target(t,iso,"livst_milk")$(p15_intake_detail(t,iso,"livst_milk")
                                                               > f15_rec_EATLancet(iso,"t_livst_milk","max")
                                                            ) =
             f15_rec_EATLancet(iso,"t_livst_milk","max");
    );

*' lower bound for fish
    if (s15_exo_fish = 1,
         p15_intake_detailed_scen_target(t,iso,"fish")$(p15_intake_detail(t,iso,"fish")
                                                            < f15_rec_EATLancet(iso,"t_fish","min")
                                                        ) =
               f15_rec_EATLancet(iso,"t_fish","min");
    );


*** Special case: Fruits, vegetables, nuts, and roots ***
*' In MAgPIE fruits, vegetables and certain nuts are combined in the 'other' food category;
*' Starchy fruits (bananas and plantains) are included in the 'cassav_sp' category.
*' The f15_fruitveg2others_kcal_ratio gives the country-level historical share
*' (fixed into the future based on last historic year)
*' of fruits and vegetables in these aggregate categories.
    if (sum(sameas(t_past,t),1) = 1,
        i15_fruit_ratio(t,iso,EAT_special) = f15_fruitveg2others_kcal_ratio(t,iso,EAT_special);
    else
        i15_fruit_ratio(t,iso,EAT_special) = i15_fruit_ratio(t-1,iso,EAT_special);
    );

*' Separation of starchy fruits (bananas and plantains)
*' and roots (cassava, sweet potato, yams) in the cassav_sp food category
        p15_intake_detail_starchyfruit(t,iso) = i15_fruit_ratio(t,iso,"cassav_sp") * p15_intake_detail(t,iso,"cassav_sp");
        p15_intake_detail_roots(t,iso) = (1 - i15_fruit_ratio(t,iso,"cassav_sp")) * p15_intake_detail(t,iso,"cassav_sp") + p15_intake_detail(t,iso,"potato");

* Initialize scenario target for case that switch is not active
        p15_intake_detailed_scen_starchyfruit(t,iso) = p15_intake_detail_starchyfruit(t,iso);
        p15_intake_detailed_scen_roots(t,iso) = p15_intake_detail_roots(t,iso);
        p15_intake_detailed_scen_target(t,iso,"potato") = p15_intake_detail(t,iso,"potato");

*' lower bound for fruits, veggies, nuts and seeds
    if (s15_exo_fruitvegnut = 1,

*' Maximum recommendation for starchy fruits:
        p15_intake_detailed_scen_starchyfruit(t,iso)$(p15_intake_detail_starchyfruit(t,iso) > f15_rec_EATLancet(iso,"t_fruitstarch","max"))
           = f15_rec_EATLancet(iso,"t_fruitstarch","max");

*' Split the 'others' category into fruits plus vegetables and nuts
        p15_intake_detail_fruitveg(t,iso) = i15_fruit_ratio(t,iso,"others") * p15_intake_detail(t,iso,"others") + p15_intake_detailed_scen_starchyfruit(t,iso);
        p15_intake_detail_nuts(t,iso) = (1 - i15_fruit_ratio(t,iso,"others")) * p15_intake_detail(t,iso,"others");
        p15_intake_detailed_scen_fruitveg(t,iso) = p15_intake_detail_fruitveg(t,iso);
        p15_intake_detailed_scen_nuts(t,iso) = p15_intake_detail_nuts(t,iso);

*' Minimum recommendation for fruits and vegetables:
        p15_intake_detailed_scen_fruitveg(t,iso)$(p15_intake_detail_fruitveg(t,iso) < f15_rec_EATLancet(iso,"t_fruitveg","min"))
            = f15_rec_EATLancet(iso,"t_fruitveg","min");

*' Extract fruits and vegetables that are part of others category
*  Note that starchy fruits are kept at the previously assigned maximum level
*  and their amount will be added to cassav_sp.
        p15_intake_detailed_scen_fruitveg(t,iso) = p15_intake_detailed_scen_fruitveg(t,iso) - p15_intake_detailed_scen_starchyfruit(t,iso);

*' Minimum recommendation for nuts & seeds
*' (a) nuts included in "others"
*' are scaled by the same amount as fruits and vegetables
*' because the food group "others" is treated as homogenous food category
        p15_intake_detailed_scen_nuts(t,iso)$(p15_intake_detail_fruitveg(t,iso) - p15_intake_detailed_scen_starchyfruit(t,iso) > 0)
            = p15_intake_detail_nuts(t,iso) * p15_intake_detailed_scen_fruitveg(t,iso) / (p15_intake_detail_fruitveg(t,iso) - p15_intake_detailed_scen_starchyfruit(t,iso))
          ;

*' The resulting intake of the "others" category is:
        p15_intake_detailed_scen_target(t,iso,"others") = p15_intake_detailed_scen_fruitveg(t,iso) + p15_intake_detailed_scen_nuts(t,iso);

*' (b) remaining nuts (groundnut) and seeds (rapeseed, sunflower) are scaled
*' up or down towards the EAT nuts target
*' considering scaling of nuts in others.
        p15_intake_detailed_scen_target(t,iso,kfo_ns)$(sum(kfo_ns2, p15_intake_detail(t,iso,kfo_ns2)) > 0)
            = p15_intake_detail(t,iso,kfo_ns) / sum(kfo_ns2, p15_intake_detail(t,iso,kfo_ns2))
                * (f15_rec_EATLancet(iso,"t_nutseeds","min") - p15_intake_detailed_scen_nuts(t,iso));


* If seeds have been corrected downwards below zero because nuts target already overfulfilled with nuts in others,
* seed and groundnut consumption is reduced to zero.
        p15_intake_detailed_scen_target(t,iso,kfo_ns)$(p15_intake_detailed_scen_target(t,iso,kfo_ns) < 0) = 0;

    );

*' upper bound for roots
    if (s15_exo_roots = 1,

*' Maximum recommendation for roots:
        p15_intake_detailed_scen_roots(t,iso)$(p15_intake_detail_roots(t,iso) > f15_rec_EATLancet(iso,"t_roots","max")) =
          f15_rec_EATLancet(iso,"t_roots","max");

        p15_intake_detailed_scen_target(t,iso,"potato")$(p15_intake_detail_roots(t,iso) > f15_rec_EATLancet(iso,"t_roots","max")) =
          p15_intake_detailed_scen_roots(t,iso) / p15_intake_detail_roots(t,iso) * p15_intake_detail(t,iso,"potato");

    );

* Assign starchy fruit and cassava roots back to cassava_sp scenario target
    p15_intake_detailed_scen_target(t,iso,"cassav_sp") =
      p15_intake_detailed_scen_roots(t,iso) -
      p15_intake_detailed_scen_target(t,iso,"potato") +
      p15_intake_detailed_scen_starchyfruit(t,iso);

*' lower bound for legumes
    if (s15_exo_pulses = 1,
       p15_intake_detailed_scen_target(t,iso,EAT_pulses15)$(sum(EAT_pulses15_2, p15_intake_detail(t,iso,EAT_pulses15_2))
                                                                 < f15_rec_EATLancet(iso,"t_legumes","min")
                                                               ) =
            (p15_intake_detail(t,iso,EAT_pulses15) / sum(EAT_pulses15_2, p15_intake_detail(t,iso,EAT_pulses15_2)))
             * f15_rec_EATLancet(iso,"t_legumes","min");
    );

*' upper bound for sugar
    if (s15_exo_sugar = 1,
      p15_intake_detailed_scen_target(t,iso,"sugar")$(p15_intake_detail(t,iso,"sugar")
                                                              > f15_rec_EATLancet(iso,"t_sugar","max")
                                                           ) =
            f15_rec_EATLancet(iso,"t_sugar","max");
    );

*' upper and lower bound for oils
    if (s15_exo_oils = 1,
* oil_veg has a minimum and maximum recommendation in EAT
       p15_intake_detailed_scen_target(t,iso,"oils")$(p15_intake_detail(t,iso,"oils")
                                                       < f15_rec_EATLancet(iso,"t_oils","min")
                                                      ) =
            f15_rec_EATLancet(iso,"t_oils","min");

* oil palm has a maximum recommendation in EAT
       p15_intake_detailed_scen_target(t,iso,"oils")$(p15_intake_detail(t,iso,"oils")
                                                        > f15_rec_EATLancet(iso,"t_oils","max")
                                                     ) =
            f15_rec_EATLancet(iso,"t_oils","max");
    );


* Food commodities that are not included in diet recommendations are set to zero:
 p15_intake_detailed_scen_target(t,iso,kfo_norec) = 0;

* Optionally, there is an exception for alcohol if s15_exo_alcohol = 1:
* Even though it would be 0 following the EAT Lancet recommendation,
* an alternative maximum target can be set via 's15_alc_scen' for alcohol consumption,
* e.g. following the recommendation according to Lassen et al., (2020).
    if (s15_exo_alcohol = 1,
       p15_intake_detailed_scen_target(t,iso,"alcohol")$(p15_intake_detailed_scen_target(t,iso,"alcohol") > s15_alc_scen * i15_intake_scen_target(t,iso))
        = s15_alc_scen * i15_intake_scen_target(t,iso);
      );
*' There is no explicit target for brans in the EATLancet recommendations.
*' It is set to 0 when s15_exo_brans is activated.
    if (s15_exo_brans = 1,
       p15_intake_detailed_scen_target(t,iso,"brans") = 0;
       );
*' There is no explicit target for single cell protein in the EATLancet recommendations.
*' It is therefore set to 0.
    if (s15_exo_scp = 1,
       p15_intake_detailed_scen_target(t,iso,"scp") = 0;
       );

*** Balancing calorie requirements ***
*' After all calorie recommendations for non-staple food groups are satisfied,
*' intake of staple crops is now modified such that
*' the above-selected total calorie intake is met.
  p15_intake_detailed_scen_target(t,iso,EAT_staples)$(sum(EAT_staples2, p15_intake_detail(t,iso,EAT_staples2)) > 0) =
      (i15_intake_scen_target(t,iso) - sum(EAT_nonstaples2, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2)))
       * (p15_intake_detail(t,iso,EAT_staples) / sum(EAT_staples2, p15_intake_detail(t,iso,EAT_staples2)));


* Correction where calorie balancing would lead to negative p15_intake_detailed_scen_target values
  p15_intake_detailed_scen_target(t,iso,EAT_staples)$(i15_intake_scen_target(t,iso) - sum(EAT_nonstaples2, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2)) < 0) =
         0;
  p15_intake_detailed_scen_target(t,iso,EAT_nonstaples)$(i15_intake_scen_target(t,iso) - sum(EAT_nonstaples2, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2)) < 0) =
         i15_intake_scen_target(t,iso) * p15_intake_detailed_scen_target(t,iso,EAT_nonstaples) /
         sum(EAT_nonstaples2, p15_intake_detailed_scen_target(t,iso,EAT_nonstaples2));

  if (smin((iso,kfo), p15_intake_detailed_scen_target(t,iso,kfo)) < (-1e-10),
     display p15_intake_detailed_scen_target;
     abort "The parameter p15_intake_detailed_scen_target became negative after calorie balancing.";
     );

* Correction of very small values
  p15_intake_detailed_scen_target(t,iso,kfo)$(p15_intake_detailed_scen_target(t,iso,kfo) < 0) = 0;


);
*** End of MAgPIE-specific realization of the EAT Lancet diet

*'  3.) In the third step, the regression-based calculation of intake
*' is faded into the exogenous intake scenario according to a predefined speed of
*' convergence (note that fading should start after the historical time slice of
*' the EAT Lancet diet scenarios (y2010) as defined in `i15_exo_foodscen_fader(t,iso)`):
  p15_intake_detail(t,iso,kfo) = p15_intake_detail(t,iso,kfo) * (1-i15_exo_foodscen_fader(t,iso))
                      + p15_intake_detailed_scen_target(t,iso,kfo) * i15_exo_foodscen_fader(t,iso);

  p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) = p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) * (1-i15_exo_foodscen_fader(t,iso))
                      + p15_bmi_shr_target(t,iso,sex,age,bmi_group15) * i15_exo_foodscen_fader(t,iso);

);
*** End of special postprocessing food demand scenarios.


*' 4.) The fourth step estimates the calorie supply at household level by multiplying
*' daily per capita calorie intake with the demand2intake ratio that was estimated
*' previously. It assures that if commodities with higher food waste ratio are
*' increasingly consumed, food waste increases.
  p15_kcal_pc_iso(t,iso,kfo) = p15_intake_detail(t,iso,kfo)
                                * p15_demand2intake_ratio_detail(t,iso,kfo);

*' Total waste share and total intake are adapted to new calculations.
  p15_intake_total(t,iso) = sum(kfo, p15_intake_detail(t,iso,kfo));
  p15_waste_pc(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_intake_detail(t,iso,kfo);

  p15_demand2intake_ratio(t,iso) = 1$(p15_intake_total(t,iso) = 0) +
         (sum(kfo,p15_kcal_pc_iso(t,iso,kfo)) / p15_intake_total(t,iso))$(
           p15_intake_total(t,iso) > 0);


* ###### Exogenous food waste scenario
if (s15_exo_waste = 1,

*' "Downwards convergence" of regional calorie oversupply due to food waste to the
*' waste reduction target, i.e. only for values that are higher than the target:
    p15_demand2intake_ratio(t,iso)$(p15_demand2intake_ratio(t,iso) > s15_waste_scen )
                      = p15_demand2intake_ratio(t,iso) * (1-i15_exo_foodscen_fader(t,iso))
                        + s15_waste_scen * i15_exo_foodscen_fader(t,iso);

);

*' waste calculation by crop type
    p15_waste_pc(t,iso,kfo)$(sum(kfo2, p15_waste_pc(t,iso,kfo2))<>0) = p15_waste_pc(t,iso,kfo) / sum(kfo2, p15_waste_pc(t,iso,kfo2)) *
                  (p15_intake_total(t,iso)*p15_demand2intake_ratio(t,iso) - p15_intake_total(t,iso));

*' Waste ratio is applied
    p15_kcal_pc_iso(t,iso,kfo) = p15_intake_detail(t,iso,kfo) + p15_waste_pc(t,iso,kfo);

*' Demand intake detail
    p15_demand2intake_ratio_detail(t,iso,kfo)=1$(p15_intake_detail(t,iso,kfo) = 0) +
                  (p15_kcal_pc_iso(t,iso,kfo) / p15_intake_detail(t,iso,kfo))$(p15_intake_detail(t,iso,kfo) > 0);


*' The country-level parameter p15_kcal_pc_iso is aggregated to the
*' regional level. After removing estimates from countries that are not included
*' in FAOSTAT, the resulting parameter p15_kcal_pc_calibrated is provided to
*' constraint q15_food_demand in the MAgPIE model, which defines the demand for food.

*' Results are aggregated to regions
   p15_kcal_pc(t,i,kfo)$(
      sum(i_to_iso(i,iso),
         im_pop_iso(t,iso)
      ) > 0) =
               sum(i_to_iso(i,iso),
                 p15_kcal_pc_iso(t,iso,kfo)
                 * im_pop_iso(t,iso)
               ) / sum(i_to_iso(i,iso),
                   im_pop_iso(t,iso)
               );

   p15_balanceflow_kcal(t,i,kfo)$(
      sum(i_to_iso(i,iso),
         im_pop_iso(t,iso)
      ) > 0) =
               sum(i_to_iso(i,iso),
                 p15_balanceflow_kcal_iso(t,iso,kfo)
                 * im_pop_iso(t,iso)
               ) / sum(i_to_iso(i,iso),
                   im_pop_iso(t,iso)
               );


*' Finally, countries with zero food demand according to FAOSTAT are calibrated
*' down to zero to match FAO world totals.
*' Values are rounded to avoid path dependencies of MAgPIE solver.
   p15_kcal_pc_calibrated(t,i,kfo) = p15_kcal_pc(t,i,kfo) + p15_balanceflow_kcal(t,i,kfo);
   p15_kcal_pc_calibrated(t,i,kfo) = round(p15_kcal_pc_calibrated(t,i,kfo), 2);
   p15_kcal_pc_calibrated(t,i,kfo)$(p15_kcal_pc_calibrated(t,i,kfo) < 0) = 0;

*' @stop
 );
