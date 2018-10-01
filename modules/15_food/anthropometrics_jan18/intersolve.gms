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
    display "Coupling: Reading out Marginal Costs from MAgPIE as shock to demand model";
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
                              abs(p15_delta_income(t,i) / p15_lastiteration_delta_income(i)- 1)
                            );


* keeping current deltas for estimating convergence in next timestep
 p15_lastiteration_delta_income(i) = p15_delta_income(t,i);


*' @code
*' If `s15_elastic_demand` is 0, MAgPIE is not executed again for this time step.
*' In case that `s15_elastic_demand` is 1, it is checked whether MAgPIE and the
*' food demand model have reached sufficient convergence. The criterion for this
*' is whether the real income in the food demand model has changed in any country
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

* estimating calibrated values for height regression
* add balanceflow for calibration
         p15_kcal_pc_iso(t,iso,kfo) =  v15_kcal_regr.l(iso,kfo) + p15_kcal_calib(t,iso,kfo) * s15_calibrate;

* set negative values that can occur due to calibration to zero
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

* we calibrate countries with zero food demand according to FAOSTAT
* down to zero to match FAO values-
* Values are rounded to avoid path dependencies of MAgPIE solver
       p15_kcal_pc_calibrated(t,i,kfo)=p15_kcal_pc(t,i,kfo)+p15_balanceflow_kcal(t,i,kfo);
       p15_kcal_pc_calibrated(t,i,kfo)=round(p15_kcal_pc_calibrated(t,i,kfo),2);
       p15_kcal_pc_calibrated(t,i,kfo)$(p15_kcal_pc_calibrated(t,i,kfo)<0)=0;


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


*' The calibration parameter is added to the regression value

   p15_bmi_shr(t,iso,sex,age,bmi_group15) =
           v15_bmi_shr_regr.l(iso,sex,age,bmi_group15)+
           i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

*' The BMI shares are not allowed to exceed the bounds 0 and 1. Values are corrected to the bounds.
   p15_bmi_shr(t,iso,sex,age,bmi_group15)$(p15_bmi_shr(t,iso,sex,age,bmi_group15)<0) = 0;
   p15_bmi_shr(t,iso,sex,age,bmi_group15)$(p15_bmi_shr(t,iso,sex,age,bmi_group15)>1) = 1;
*' The mismatch is balanced by moving the exceeding quantities into the middle BMI group.
   p15_bmi_shr(t,iso,sex,age,"medium")=
      1 - (sum(bmi_group15, p15_bmi_shr(t,iso,sex,age,bmi_group15)) - p15_bmi_shr(t,iso,sex,age,"medium"));

*' We recalculate the intake with the new values
   p15_kcal_intake_total(t,iso) =
         (
           sum((sex, age, bmi_group15),
               p15_bmi_shr(t,iso,sex,age,bmi_group15)*
               im_demography(t,iso,sex,age) *
               i15_intake(t,iso,sex,age,bmi_group15)
           ) + i15_kcal_pregnancy(t,iso)
         )/sum((sex,age), im_demography(t,iso,sex,age));



if(ord(t)>1,
* start from bodyheight structure of last period
   p15_bodyheight(t,iso,sex,age,"final") = p15_bodyheight(t-1,iso,sex,age,"final");
   p15_kcal_growth_food(t,iso,underaged15) = p15_kcal_growth_food(t-1,iso,underaged15);
);

s15_count=m_yeardiff(t);
if(s15_count<5,s15_count=5);

For (s15_count = 1 to (m_yeardiff(t)/5),

* circular move of age by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
   p15_bodyheight(t,iso,sex,age++1,"final") = p15_bodyheight(t,iso,sex,age,"final");

*  move on consumption agegroups by 5 years
   p15_kcal_growth_food(t,iso,underaged15++1)=
            p15_kcal_growth_food(t,iso,underaged15);

*  consumption is calculated as linear interpolation between timesteps
   p15_kcal_growth_food(t,iso,"0--4") =
            sum(growth_food15,
                p15_kcal_pc_iso(t,iso,growth_food15) * (s15_count / (m_yeardiff(t)/5))
                + p15_kcal_pc_iso(t-1,iso,growth_food15) * (1 - s15_count / (m_yeardiff(t)/5))
            );
*' @code
*' After each execution of the food demand model, the body height distribution
*' of the population is estimated. The starting point is the body height
*' distribution of the last timestep. The body height estimates of the old
*' period are moved into the subsequent age class (e.g. the 20-24 year old are
*' now 25-29 years old). The age class of 15-19 year olds is estimated newly
*' using the body height regressions and the food consumption of the last 15
*' years.

   p15_bodyheight(t,iso,"F","15--19","final") =
                     126.4*
                     (sum(underaged15,
                       p15_kcal_growth_food(t,iso,underaged15)
                     )/3)**0.03464
                     ;
   p15_bodyheight(t,iso,"M","15--19","final") =
                     131.8*
                     (sum(underaged15,
                       p15_kcal_growth_food(t,iso,underaged15)
                     )/3)**0.03975
                     ;
*' @stop
);

*' @code
*' The bodyheight of the underaged age class (0-14) is assumed to diverge from 'normal'
*' body height by the same proportion as age class of the 15-19 year olds.
*' This  rotation is repeated for the 5-year length of the time step, it is repeated
*' 3 times.

p15_bodyheight(t,iso,"M","0--4","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*92;
p15_bodyheight(t,iso,"M","5--9","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*125;
p15_bodyheight(t,iso,"M","10--14","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*152;

p15_bodyheight(t,iso,"F","0--4","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*91;
p15_bodyheight(t,iso,"F","5--9","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*124;
p15_bodyheight(t,iso,"F","10--14","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*154;

*' @stop

*' @code
*' Finally, the regression outcome is calibrated by a country-specific additive
*' term, which is the residual of the regression fit and observation of the last
*' historical time step

if (sum(sameas(t_past,t),1) = 1,
* for historical period only use estimate to calibrate balanceflow but use historical data for values
  p15_bodyheight_calib(t,iso,sex,age_new_estimated15) = f15_bodyheight(t,iso,sex,age_new_estimated15) - p15_bodyheight(t,iso,sex,age_new_estimated15,"final");
  p15_bodyheight(t,iso,sex,age_new_estimated15,"final") = f15_bodyheight(t,iso,sex,age_new_estimated15);
else
  p15_bodyheight_calib(t,iso,sex,age_new_estimated15)=p15_bodyheight_calib(t-1,iso,sex,age_new_estimated15);
  p15_bodyheight(t,iso,sex,age_new_estimated15,"final")=p15_bodyheight(t,iso,sex,age_new_estimated15,"final")+p15_bodyheight_calib(t,iso,sex,age_new_estimated15)*s15_calibrate;
);

*' @stop