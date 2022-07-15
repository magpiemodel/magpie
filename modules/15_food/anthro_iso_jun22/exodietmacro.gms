*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
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
   p15_kcal_pc_iso(t,iso,kfo)$(p15_kcal_pc_iso(t,iso,kfo)<0) = 0;

* saving regression outcome for BMI shares
  p15_bmi_shr_regr(t,iso,sex,age,bmi_group15) = v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);

  p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) =
         p15_bmi_shr_regr(t,iso,sex,age,bmi_group15)+
         i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

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

*** Substitution of ruminant meat and dairy products (kfo_rd) with single-cell protein (SCP) based on protein/cap/day
  i15_protein_to_kcal_ratio(t,kfo) =  f15_nutrition_attributes(t,kfo,"protein")/f15_nutrition_attributes(t,kfo,"kcal");
* Before the substitution, kfo_rd is converted from kcal/cap/day to g protein/cap/day
* using i15_protein_to_kcal_ratio(t,kfo_rd).
* After the substitution of kfo_rd with SCP (1-i15_rumdairy_scp_fadeout), SCP is converted
* back to kcal/cap/day using i15_protein_to_kcal_ratio(t,"scp").
  p15_kcal_pc_iso(t,iso,"scp") = p15_kcal_pc_iso(t,iso,"scp") +
  	sum(kfo_rd, p15_kcal_pc_iso(t,iso,kfo_rd) * (1-i15_rumdairy_scp_fadeout(t,iso)) *
  	i15_protein_to_kcal_ratio(t,kfo_rd)) / i15_protein_to_kcal_ratio(t,"scp");
  p15_kcal_pc_iso(t,iso,kfo_rd) = p15_kcal_pc_iso(t,iso,kfo_rd) * i15_rumdairy_scp_fadeout(t,iso);


* Conditional reduction of livestock products (without fish) depending on s15_kcal_pc_livestock_intake_target.
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

  p15_kcal_pc_livestock_supply_target(iso) = s15_kcal_pc_livestock_intake_target * f15_overcons_FAOwaste(iso,"livst_rum");

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

* first apply FAO waste factors, than rescale intake proportionally to meet total intake
* This distributes the differences in waste estimates rather equally over different products

  p15_intake_detail(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo)/f15_overcons_FAOwaste(iso,kfo);

  p15_intake_detail(t,iso,kfo)$(sum(kfo2, p15_intake_detail(t,iso,kfo2))<>0) =
                    p15_intake_detail(t,iso,kfo) / sum(kfo2, p15_intake_detail(t,iso,kfo2))*
                    p15_intake_total(t,iso);
* to avoid negative waste, we reduce intake where it exceed food availabiltiy

  p15_intake_detail(t,iso,kfo)$(p15_intake_detail(t,iso,kfo)>p15_kcal_pc_iso(t,iso,kfo)) =
                  p15_kcal_pc_iso(t,iso,kfo);

* in a second round of calibration, we rescale food waste to meet total food waste.
* Now, waste is increasing only where there is already waste.

   p15_waste_pc(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_intake_detail(t,iso,kfo);

   p15_waste_pc(t,iso,kfo) = 0$(sum(kfo2, p15_waste_pc(t,iso,kfo2))=0) + (
                    p15_waste_pc(t,iso,kfo) / sum(kfo2, p15_waste_pc(t,iso,kfo2))*
                    (p15_intake_total(t,iso)*p15_demand2intake_ratio(t,iso)-p15_intake_total(t,iso))
                    )$(sum(kfo2, p15_waste_pc(t,iso,kfo2))<>0);

   p15_intake_detail(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_waste_pc(t,iso,kfo);


* the third calibration is only needed for those countries where total intake exceeds calory availabtility
* here we want to have the inconsistency in the waste, not in the intake.

   p15_intake_detail(t,iso,kfo)$(sum(kfo2, p15_intake_detail(t,iso,kfo2))<>0) =
                     p15_intake_detail(t,iso,kfo) / sum(kfo2, p15_intake_detail(t,iso,kfo2))*
                     p15_intake_total(t,iso);
   p15_waste_pc(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_intake_detail(t,iso,kfo);

* we calculate a product specific demand2intake ratio
   p15_demand2intake_ratio_detail(t,iso,kfo)=1$(p15_intake_detail(t,iso,kfo) = 0) +
            (p15_kcal_pc_iso(t,iso,kfo) / p15_intake_detail(t,iso,kfo))$(p15_intake_detail(t,iso,kfo) > 0);

* Bodyheight is estimated based on a calorie availabiltiy regression, including
* waste. As food waste scenarios should not affect bodyheight, we apply the
* normal food waste ratios for the growth estimates
  p15_demand2intake_ratio_detail_preexo(t,iso,kfo)=p15_demand2intake_ratio_detail(t,iso,kfo);

* ###### Exogenous EAT Lancet diet scenario

*' @code
*' Transition to exogenous Planetary Health diet scenarios [@willett_food_2019]:
*' It is possible to define exogenous diet scenarios that replace the regression-based
*' calculation of food intake and demand according to a predefined speed of
*' convergence from `p15_kcal_pc_calibrated(t,iso,kfo)` to the scenario-dependent target
*' `i15_kcal_pc_scen_target(t,iso,kfo)` by setting the switch `s15_exo_diet`
*' to 1.


  if(s15_exo_diet = 1,

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
$elseif "%c15_kcal_scen%" == "endo"
  i15_intake_scen_target(t,iso) = p15_intake_total(t,iso);
  p15_bmi_shr_target(t,iso,sex,age,bmi_group15) = p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15);
$else
  i15_intake_scen_target(t,iso) = sum(kfo,i15_intake_EATLancet_all(iso,"%c15_kcal_scen%","%c15_EAT_scen%",kfo));
  p15_bmi_shr_target(t,iso,sex,age,bmi_group15)=0;
  p15_bmi_shr_target(t,iso,sex,age,"medium")=1;
$endif


*' Intake target is adjusted to meet the calorie target
  i15_intake_detailed_scen_target(t,iso,kfo)$(p15_intake_total(t,iso)>0) =
    p15_intake_detail(t,iso,kfo) / p15_intake_total(t,iso) * i15_intake_scen_target(t,iso);

*' 2.) The second step defines the daily per capita intake of different food
*' commodities by filling up the scenario target for total daily per capita food
*' intake according to different scenario assumptions on dietary patterns. Calories
*' for staple crops can be modified in order to meet the total calorie target.

*' The EAT lancet target values are the same for non-staples irrespective of the calorie target
*' Only non-staples differ

    i15_intake_EATLancet(iso,kfo) =
          i15_intake_EATLancet_all(iso,"2100kcal","%c15_EAT_scen%",kfo);

    if (s15_exo_monogastric=1,
      i15_intake_detailed_scen_target(t,iso,EAT_monogastrics15) = i15_intake_EATLancet(iso,EAT_monogastrics15));
    if (s15_exo_ruminant=1,
        i15_intake_detailed_scen_target(t,iso,EAT_ruminants15) = i15_intake_EATLancet(iso,EAT_ruminants15));
    if (s15_exo_fish=1,
        i15_intake_detailed_scen_target(t,iso,"fish") = i15_intake_EATLancet(iso,"fish"));
    if (s15_exo_fruitvegnut=1,
      i15_intake_detailed_scen_target(t,iso,EAT_fruitvegnutseed15) = i15_intake_EATLancet(iso,EAT_fruitvegnutseed15));
    if (s15_exo_pulses=1,
      i15_intake_detailed_scen_target(t,iso,EAT_pulses15) = i15_intake_EATLancet(iso,EAT_pulses15));
    if (s15_exo_sugar=1,
      i15_intake_detailed_scen_target(t,iso,EAT_sugar15) = i15_intake_EATLancet(iso,EAT_sugar15));
    if (s15_exo_oils=1,
      i15_intake_detailed_scen_target(t,iso,"oils") = i15_intake_EATLancet(iso,"oils"));
    if (s15_exo_brans=1,
      i15_intake_detailed_scen_target(t,iso,"brans") = i15_intake_EATLancet(iso,"brans"));
    if (s15_exo_scp=1,
      i15_intake_detailed_scen_target(t,iso,"scp") = i15_intake_EATLancet(iso,"scp"));
    if (s15_exo_alcohol=1,
* alcohol target is not part of EAT Lancet recommendation. Upper boundary is therefore included as specific swtich s15_alc_scen
      i15_intake_detailed_scen_target(t,iso,"alcohol")$(i15_intake_detailed_scen_target(t,iso,"alcohol") > s15_alc_scen*i15_intake_scen_target(t,iso))
        = s15_alc_scen*i15_intake_scen_target(t,iso);
    );

    i15_intake_detailed_scen_target(t,iso,EAT_staples)$(sum(EAT_staples2,i15_intake_EATLancet(iso,EAT_staples2))>0) = (
              i15_intake_scen_target(t,iso) - sum(EAT_nonstaples,i15_intake_detailed_scen_target(t,iso,EAT_nonstaples)) )*(
              i15_intake_EATLancet(iso,EAT_staples)/sum(EAT_staples2,i15_intake_EATLancet(iso,EAT_staples2)) );

*'  3.) In the third step, the regression-based calculation of intake
*' is faded into the exogenous intake scenario according to a predefined speed of
*' convergence (note that fading should start after the historical time slice of
*' the EAT Lancet diet scenarios (y2010) as defined in `i15_exo_foodscen_fader(t,iso)`):
  p15_intake_detail(t,iso,kfo) = p15_intake_detail(t,iso,kfo) * (1-i15_exo_foodscen_fader(t,iso))
                      + i15_intake_detailed_scen_target(t,iso,kfo) * i15_exo_foodscen_fader(t,iso);

  p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) = p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15) * (1-i15_exo_foodscen_fader(t,iso))
                      + p15_bmi_shr_target(t,iso,sex,age,bmi_group15) * i15_exo_foodscen_fader(t,iso);

*' 4.) The fourth step estimates the calorie supply at household level by multiplying
*' daily per capita calorie intake with the demand2intake ratio that was estimated
*' previously. It assures that if commodities with higher food waste ratio are
*' increasingly consumed, food waste increases.
  p15_kcal_pc_iso(t,iso,kfo) = p15_intake_detail(t,iso,kfo)
                                  *p15_demand2intake_ratio_detail(t,iso,kfo);

*' Total waste share and total intake are adapted to new calculations.

  p15_intake_total(t,iso) = sum(kfo, p15_intake_detail(t,iso,kfo));
  p15_waste_pc(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo) - p15_intake_detail(t,iso,kfo);

  p15_demand2intake_ratio(t,iso) = 1$(p15_intake_total(t,iso) = 0) +
         (sum(kfo,p15_kcal_pc_iso(t,iso,kfo)) / p15_intake_total(t,iso))$(
           p15_intake_total(t,iso) > 0);

  p15_demand2intake_ratio_detail(t,iso,kfo)=1$(p15_intake_detail(t,iso,kfo) = 0) +
  (p15_kcal_pc_iso(t,iso,kfo) / p15_intake_detail(t,iso,kfo))$(p15_intake_detail(t,iso,kfo) > 0);

);
*' End of special postprocessing food demand scenarios.




* ###### Exogenous food waste scenario

  if(s15_exo_waste = 1,

*' "Downwards convergence" of regional calorie oversupply due to food waste to the
*' waste reduction target, i.e. only for values that are higher than the target:

    p15_demand2intake_ratio(t,iso)$(p15_demand2intake_ratio(t,iso) > s15_waste_scen )
                      = p15_demand2intake_ratio(t,iso)*(1-i15_exo_foodscen_fader(t,iso))
                        + s15_waste_scen*i15_exo_foodscen_fader(t,iso);

*' waste calculation by crop type

    p15_waste_pc(t,iso,kfo)$(sum(kfo2, p15_waste_pc(t,iso,kfo2))<>0) = p15_waste_pc(t,iso,kfo) / sum(kfo2, p15_waste_pc(t,iso,kfo2))*
                  (p15_intake_total(t,iso)*p15_demand2intake_ratio(t,iso)-p15_intake_total(t,iso));

*' Waste ratio is applied
    p15_kcal_pc_iso(t,iso,kfo) = p15_intake_detail(t,iso,kfo) + p15_waste_pc(t,iso,kfo);

    p15_demand2intake_ratio_detail(t,iso,kfo)=1$(p15_intake_detail(t,iso,kfo) = 0) +
                  (p15_kcal_pc_iso(t,iso,kfo) / p15_intake_detail(t,iso,kfo))$(p15_intake_detail(t,iso,kfo) > 0);

    display p15_kcal_pc_iso;
);




*' The country-level parameter p15_kcal_pc_iso is aggregated to the
*' regional level. After removing estimates from countries that are not included
*' in FAOSTAT, the resulting parameter p15_kcal_pc_calibrated is provided to
*' constraint q15_food_demand in the MAgPIE model, which defines the demand for food.

*' Results are aggregated to regions
   p15_kcal_pc(t,i,kfo)$(
      sum(i_to_iso(i,iso),
         im_pop_iso(t,iso)
      ) >0 ) =
               sum(i_to_iso(i,iso),
                 p15_kcal_pc_iso(t,iso,kfo)
                 * im_pop_iso(t,iso)
               ) / sum(i_to_iso(i,iso),
                   im_pop_iso(t,iso)
               );

   p15_balanceflow_kcal(t,i,kfo)$(
      sum(i_to_iso(i,iso),
         im_pop_iso(t,iso)
      ) >0 ) =
               sum(i_to_iso(i,iso),
                 p15_balanceflow_kcal_iso(t,iso,kfo)
                 * im_pop_iso(t,iso)
               ) / sum(i_to_iso(i,iso),
                   im_pop_iso(t,iso)
               );


*' Finally, we calibrate countries with zero food demand according to FAOSTAT
*' down to zero to match FAO world totals.
*' Values are rounded to avoid path dependencies of MAgPIE solver.
   p15_kcal_pc_calibrated(t,i,kfo)=p15_kcal_pc(t,i,kfo)+p15_balanceflow_kcal(t,i,kfo);
   p15_kcal_pc_calibrated(t,i,kfo)=round(p15_kcal_pc_calibrated(t,i,kfo),2);
   p15_kcal_pc_calibrated(t,i,kfo)$(p15_kcal_pc_calibrated(t,i,kfo)<0)=0;

*' @stop
 );
