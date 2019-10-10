*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

option nlp = conopt4

* retrieving interfaces from MAgPIE
* calculate prices for providing 1 kcal per day of one commodity

*' @code
*' After one time step of MAgPIE is executed, the shadow prices of the food demand
*' constraint are fed back into the food demand module, and the food demand
*' module is executed once again.
*' @stop

if (magpie.modelstat = NA,
    q15_food_demand.m(i,kfo)=0;
    p15_prices_kcal(t,iso,kfo)=i15_prices_initial_kcal(iso,kfo)*f15_price_index(t);
else
    display "Coupling: Reading out marginal costs from MAgPIE as shock to demand model";
    p15_prices_kcal(t,iso,kfo)=sum(i_to_iso(i,iso), q15_food_demand.m(i,kfo));
);

p15_iteration_counter(t)= p15_iteration_counter(t) + 1;

display "starting m15_food_demand model....";

solve m15_food_demand USING nlp MAXIMIZING v15_objective ;
p15_modelstat(t) = m15_food_demand.modelstat;

display "Food Demand Model finished with modelstat ";
display p15_modelstat;

if(( p15_modelstat(t)) > 2 and (p15_modelstat(t) ne 7 ),
  m15_food_demand.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "Food Demand Model became infeasible. Should not be possible.";
);


* estimate regional indicators from demand model


 p15_income_pc_real_ppp(t,i)$(
     sum(i_to_iso(i,iso),
       im_pop_iso(t,iso)
     ) >0 ) =
                             sum(i_to_iso(i,iso),
                               v15_income_pc_real_ppp_iso.l(iso)
                               * im_pop_iso(t,iso)
                             ) / sum(i_to_iso(i,iso),
                                 im_pop_iso(t,iso)
                             );

 p15_delta_income(t,i) = p15_income_pc_real_ppp(t,i) / im_gdp_pc_ppp(t,i);

* estimate convergence measure for deciding to stop iteration


 p15_convergence_measure(t) =smax(i,
                              abs(p15_delta_income(t,i) / p15_lastiteration_delta_income(t,i)- 1)
                            );


* keeping current deltas for estimating convergence in next timestep
 p15_lastiteration_delta_income(t,i) = p15_delta_income(t,i);


*' @code
*' If `s15_elastic_demand` is 0, MAgPIE is not executed again for this time step.
*' In case that `s15_elastic_demand` is 1, it is checked whether MAgPIE and the
*' food demand model have reached sufficient convergence. The criterion for this
*' is whether the real income in the food demand model has changed in any region
*' by more than `s15_convergences_measure` relative to the last iteration due to
*' changes in food prices from MAgPIE. Moreover, the model aborts when the
*' number of iterations reaches `s15_maxiter`.
*' As long as the iteration continues, the food prices are transferred from
*' MAgPIE to the food demand model, and the food demand is transferred from
*' the food demand model to MAgPIE.
*' @stop


display "finished iteration number ", p15_iteration_counter;
display "convergence measure:",p15_convergence_measure;

if (s15_elastic_demand * (1-sum(sameas(t_past,t),1)) =1,
  display "elastic demand model is activated";
  if ((p15_convergence_measure(t) > s15_convergence and p15_iteration_counter(t) <= s15_maxiter),

        display "convergence between MAgPIE and Food Demand Model not yet reached";
        sm_intersolve=0;

* saving regression outcome for postprocessing
         p15_kcal_regr(t, iso, kfo)=v15_kcal_regr.l(iso, kfo);
         p15_bmi_shr_regr(t,iso,sex,age,bmi_group15)=v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);

* The calibration factor is added to the regression value.
         p15_kcal_pc_iso(t,iso,kfo) =  v15_kcal_regr.l(iso,kfo) + p15_kcal_calib(t,iso,kfo) * s15_calibrate;

* Negative values that can possibly occur due to calibration are set to zero.
         p15_kcal_pc_iso(t,iso,kfo)$(p15_kcal_pc_iso(t,iso,kfo)<0) = 0;

* aggregate to regions
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

* We calibrate countries with zero food demand according to FAOSTAT
* down to zero to match FAO world totals.
* Values are rounded to avoid path dependencies of MAgPIE solver.
       p15_kcal_pc_calibrated(t,i,kfo)=p15_kcal_pc(t,i,kfo)+p15_balanceflow_kcal(t,i,kfo);
       p15_kcal_pc_calibrated(t,i,kfo)=round(p15_kcal_pc_calibrated(t,i,kfo),2);
       p15_kcal_pc_calibrated(t,i,kfo)$(p15_kcal_pc_calibrated(t,i,kfo)<0)=0;


*###############################################################################
* INSERTION within if-statement (case that "elastic demand model is activated"
* and "convergence between MAgPIE and Food Demand Model not yet reached":

* This insertion is needed in case that elastic demand mode is combined with
* additional exogenous scenrio assumptions regarding food waste or diets



*###############################################################################
* ###### Exogenous food substitution scenarios

* "Downwards convergence" of regional calorie oversupply due to food waste to the
* waste reduction target, i.e. only for values that are higher than the target:


*' Substitution of ruminant beef with poultry:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,"livst_rum") =
               p15_kcal_pc_calibrated_orig(t,i,"livst_rum") * i15_ruminant_fadeout(t);
p15_kcal_pc_calibrated(t,i,"livst_chick") = p15_kcal_pc_calibrated_orig(t,i,"livst_chick")
             + p15_kcal_pc_calibrated_orig(t,i,"livst_rum") * (1-i15_ruminant_fadeout(t));

*' Substitution of fish with poultry:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,"fish") =
               p15_kcal_pc_calibrated_orig(t,i,"fish") * i15_fish_fadeout(t);
p15_kcal_pc_calibrated(t,i,"livst_chick") = p15_kcal_pc_calibrated_orig(t,i,"livst_chick")
             + p15_kcal_pc_calibrated_orig(t,i,"fish") * (1-i15_fish_fadeout(t));

*' Fade-out of alcohol consumption without substitution:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,"alcohol") =
               p15_kcal_pc_calibrated_orig(t,i,"alcohol") * i15_alcohol_fadeout(t);

*' Substitution of livestock products (without fish) with plant-based food commodities:
p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated_livestock_orig(t,i) = sum(kfo_lp,p15_kcal_pc_calibrated(t,i,kfo_lp));
p15_kcal_pc_calibrated_plant_orig(t,i) = sum(kfo_pp,p15_kcal_pc_calibrated(t,i,kfo_pp));

p15_livestock_kcal_structure_orig(t,i,kfo_lp)$(p15_kcal_pc_calibrated_livestock_orig(t,i)>0) =
                               p15_kcal_pc_calibrated(t,i,kfo_lp)
                               /p15_kcal_pc_calibrated_livestock_orig(t,i);

p15_plant_kcal_structure_orig(t,i,kfo_pp)$(p15_kcal_pc_calibrated_plant_orig(t,i)>0) =
                               p15_kcal_pc_calibrated(t,i,kfo_pp)
                               /p15_kcal_pc_calibrated_plant_orig(t,i);

p15_kcal_pc_calibrated(t,i,kfo_lp) = p15_livestock_kcal_structure_orig(t,i,kfo_lp)
               *p15_kcal_pc_calibrated_livestock_orig(t,i)*i15_livestock_fadeout(t);
p15_kcal_pc_calibrated(t,i,kfo_pp) = p15_plant_kcal_structure_orig(t,i,kfo_pp)
               *(p15_kcal_pc_calibrated_plant_orig(t,i)
               + p15_kcal_pc_calibrated_livestock_orig(t,i) * (1-i15_livestock_fadeout(t)));





* ######  WASTE CALCULATIONS (required for exogenous food waste or diet scenarios)

* The ratio of food demand at household level to food intake is determined
* by the amount of food that is wasted. This ratio is one of the drivers of
* future food demand trajetories.
* For the calculation of the ratio between food demand and intake, total food
* calorie intake based on CALIBRATED parameters needs to be calculated:

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

p15_intake_total_iso_calibrated(t,iso) =
       sum((sex, age, bmi_group15), p15_bmi_shr_calibrated(t,iso,sex,age,bmi_group15)*
       im_demography(t,iso,sex,age)*p15_intake(t,iso,sex,age,bmi_group15) )
       + i15_kcal_pregnancy(t,iso);

p15_intake_total_calibrated(t,i)$(sum(i_to_iso(i,iso),sum((sex,age), im_demography(t,iso,sex,age)) ) >0 )
          = sum(i_to_iso(i,iso),p15_intake_total_iso_calibrated(t,iso)
            ) / sum(i_to_iso(i,iso),
                sum((sex,age), im_demography(t,iso,sex,age))
            );

p15_demand2intake_ratio(t,i)$(p15_intake_total_calibrated(t,i) >0 ) =
         sum(kfo,p15_kcal_pc_calibrated(t,i,kfo)) /
         p15_intake_total_calibrated(t,i);

* In case, no exogenous waste scenario is selceted, the original regression-
* based estimates for food calorie oversupply are used as waste scenario.
* This information is needed in case that an exogenous diet scenario should be
* constructed from food calorie intake.
p15_demand2intake_ratio_scen(t,i) =p15_demand2intake_ratio(t,i);


* ###### Exogenous food waste scenario

if(s15_exo_waste = 1,

* "Downwards convergence" of regional calorie oversupply due to food waste to the
* waste reduction target, i.e. only for values that are higher than the target:

p15_demand2intake_ratio_scen(t,i)$(p15_demand2intake_ratio(t,i) > s15_waste_scen )
                    = p15_demand2intake_ratio(t,i)*(1-i15_exo_foodscen_fader(t))
                      + s15_waste_scen*i15_exo_foodscen_fader(t);

p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,kfo)$(p15_demand2intake_ratio(t,i) >0 ) = p15_kcal_pc_calibrated_orig(t,i,kfo)*(
                      p15_demand2intake_ratio_scen(t,i)/p15_demand2intake_ratio(t,i) );

);


* ###### Exogenous EAT Lancet diet scenario

*' @code
*' Transition to exogenous EAT Lancet diet scenarios:
*' A part of the definition of exogenous diet scenarios is already accomplished
*' in the presolve.gms, where the parameters `i15_intake_scen_target(t,i)`,
*' `i15_intake_EATLancet(i,kfo)` and `i15_intake_detailed_scen_target(t,i,kfo)`
*' are calculated.

if(s15_exo_diet = 1,


*' Now, the calorie supply at household level is calculated by multiplying
*' daily per capita calorie intake with a ratio  of supply to intake
*' (`f15_overcons_FAOwaste(i,kfo)`) based on FAO estimates on historical food waste
*' at consumption level and food conversion factors, and with a calibration
*' factor `f15_calib_fsupply(i)`. Another multiplicative factor accounts for
*' increases in food waste over time.

* In case, no exogenous waste scenario is selceted, the original regression-
* based estimates for food calorie oversupply are here used as waste scenario:
p15_foodwaste_growth(t,i) = ( 1$(p15_demand2intake_ratio_ref(i) = 0)
            + (p15_demand2intake_ratio_scen(t,i)/p15_demand2intake_ratio_ref(i))$(
              p15_demand2intake_ratio_ref(i) > 0)
              );

i15_kcal_pc_scen_target(t,i,kfo) = (f15_calib_fsupply(i)*f15_overcons_FAOwaste(i,kfo)
                                    *i15_intake_detailed_scen_target(t,i,kfo))
                                    *p15_foodwaste_growth(t,i);

*' In the last step, the regression-based calculation of daily per capita food demand
*' is faded into the exogenous diet scenario according to a predefined spped of
*' convergence:

p15_kcal_pc_calibrated_orig(t,i,kfo) = p15_kcal_pc_calibrated(t,i,kfo);
p15_kcal_pc_calibrated(t,i,kfo) = p15_kcal_pc_calibrated_orig(t,i,kfo) * (1-i15_exo_foodscen_fader(t))
                        + i15_kcal_pc_scen_target(t,i,kfo) * i15_exo_foodscen_fader(t);


);
*' @stop

*###############################################################################




        if (p15_modelstat(t) < 3,
           put_utility 'shell' / 'mv -f m15_food_demand_p.gdx m15_food_demand_' t.tl:0'.gdx';
        );

  elseif(p15_iteration_counter(t) > s15_maxiter),
      sm_intersolve=1;
      display "Warning: convergence between MAgPIE and Food Demand Model not reached after ",p15_iteration_counter," iterations. Continue to next time step!";
  else
       sm_intersolve=1;
       display "Success: convergence between MAgPIE and Food Demand Model reached after ",p15_iteration_counter," iterations";
* set back convergence indicators for next timestep
  );

else
display "exogenous demand information is used" ;
);
