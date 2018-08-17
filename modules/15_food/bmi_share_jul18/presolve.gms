option nlp = conopt4


*' @code
*' Within the major foodgroups determined by the regressions
*' '(animal calories, empty calories, fruits, vegetable and nut calories as well as staple calories)
*' we assume that the relative share of individual products (e.g. eggss with animal calories) stay
*' the same. An exception is the demand for ruminant meat, which declines in the course of the
*' century at the cost of chicken meat.
*' @stop

if (sum(sameas(t_past,t),1) = 1,

*** get share of a staple product within total staples and livestock products, and replace zero shares with reginoal avarages
* first set it to equal shares, just in case there is no population


     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap) =
                                 sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_ap)*im_pop_iso(t,iso2))/
                                 (
                                   sum((kfo_ap2,iso2),(f15_kcal_pc_iso(t,iso2,kfo_ap2)*im_pop_iso(t,iso2)))
                                   +10**(-5)
                                 );

     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap)$sum(kfo_ap2,f15_kcal_pc_iso(t,iso,kfo_ap2)>0)=
                                 f15_kcal_pc_iso(t,iso,kfo_ap) /
                                 sum(kfo_ap2,f15_kcal_pc_iso(t,iso,kfo_ap2)
*                                10**(-5) required to avoid unlogical division by zero error.
                                 );

    i15_livestock_kcal_structure_iso(t,iso,kfo_ap) = i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap);

     i15_processed_kcal_structure_iso(t,iso,kfo_pf) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_pf)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kfo_pf2,iso2),f15_kcal_pc_iso(t,iso2,kfo_pf2)*im_pop_iso(t,iso2))
                                 +10**(-5)
*                                10**(-5) required to avoid unlogical division by zero error. Ask Jan P
                               );


     i15_processed_kcal_structure_iso(t,iso,kfo_pf)$(sum(kfo_pf2,f15_kcal_pc_iso(t,iso,kfo_pf2))>0) =
                               f15_kcal_pc_iso(t,iso,kfo_pf)
                               /sum(kfo_pf2,f15_kcal_pc_iso(t,iso,kfo_pf2));



     i15_staples_kcal_structure_iso(t,iso,kfo_st) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_st)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kfo_st2,iso2),f15_kcal_pc_iso(t,iso2,kfo_st2)*im_pop_iso(t,iso2))
                                 +10**(-5)
*                                10**(-5) required to avoid unlogical division by zero error. Ask Jan P
                               );


     i15_staples_kcal_structure_iso(t,iso,kfo_st)$(sum(kfo_st2,f15_kcal_pc_iso(t,iso,kfo_st2))>0) =
                               f15_kcal_pc_iso(t,iso,kfo_st)
                               /sum(kfo_st2,f15_kcal_pc_iso(t,iso,kfo_st2));



 else
* keep staples and livestock structure constant for future projections
     i15_staples_kcal_structure_iso(t,iso,kfo_st) =i15_staples_kcal_structure_iso(t-1,iso,kfo_st);
     i15_processed_kcal_structure_iso(t,iso,kfo_pf) =i15_processed_kcal_structure_iso(t-1,iso,kfo_pf);
     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap) = i15_livestock_kcal_structure_iso_raw(t-1,iso,kfo_ap);
     i15_livestock_kcal_structure_iso(t,iso,kfo_ap)     = i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap);
     i15_livestock_kcal_structure_iso(t,iso,"livst_chick") =
                                      i15_livestock_kcal_structure_iso_raw(t,iso,"livst_chick")
                                      + i15_livestock_kcal_structure_iso_raw(t,iso,"livst_rum") * (1-i15_ruminant_fadeout(t));
     i15_livestock_kcal_structure_iso(t,iso,"livst_rum") =
                                      i15_livestock_kcal_structure_iso_raw(t,iso,"livst_rum") * i15_ruminant_fadeout(t);

 );


*' @code
*' The calculations are exectued in the following order:
*'
*' In the beginning of each timestep, the bodyheight is estimated based on the diets
*' of the previous 15 years. In case the timestep length exceed 5 years, the consumption
*' is extrapolated using the last two timesteps.
*' Bodyheight is estimated using the consumption of proteins and fats, in our case
*' the foodgroups animal products, pulses and oils.
*' To estimate the body size of underaged (0--14 years), we scale the WHO body height
*' recommendations for underaged with the divergence of the 15--19 year olds.
*' The bodyheight estimates are repeated again at the end of the timestep to improve
*' the results of the extrapolation for cases where timestep length exceeds 5 years.
*' @stop

* ###### ANTHROPOMETRIC ESIMTATES
* ### Preliminary calculation of bodyweight based on food availability of last 3 timesteps
* ### This may diverge from final calcuation in the case where timesteplength exceeds 5 years
* ### As then the demand depends on the result of MAgPIE
* ### Calculations are therefore repeated after optimization

* calculations are only made after historical period. before, we use historical values

if (sum(sameas(t_past,t),1) = 1,

   p15_bodyheight(t,iso,sex,age,estimates15) = f15_bodyheight(t,iso,sex,age);


else

    p15_bodyheight(t,iso,sex,age,"preliminary") = p15_bodyheight(t-1,iso,sex,age,"final");
    p15_kcal_growth_food(t,iso,underaged15) = p15_kcal_growth_food(t-1,iso,underaged15);

    s15_count=m_yeardiff(t);
* avoid fake 1yr timestep in 1995
    if(s15_count<5,s15_count=5);
    For (s15_count = 1 to (m_yeardiff(t)/5),

* circular move of age by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
          p15_bodyheight(t,iso,sex,age++1,"preliminary") = p15_bodyheight(t,iso,sex,age,"preliminary");

* replace age groups of 18 year olds
          p15_bodyheight(t,iso,"F","15--19","preliminary") =
                 126.4*
                 (sum(underaged15,
                   p15_kcal_growth_food(t,iso,underaged15)
                 )/3)**0.03464
                 ;
          p15_bodyheight(t,iso,"M","15--19","preliminary") =
                 131.8*
                 (sum(underaged15,
                   p15_kcal_growth_food(t,iso,underaged15)
                 )/3)**0.03975
                 ;
     );
*adjust body weight of kids proportional to over18 population
     p15_bodyheight(t,iso,"M","0--4","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*92;
     p15_bodyheight(t,iso,"M","5--9","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*125;
     p15_bodyheight(t,iso,"M","10--14","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*152;

     p15_bodyheight(t,iso,"F","0--4","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*91;
     p15_bodyheight(t,iso,"F","5--9","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*124;
     p15_bodyheight(t,iso,"F","10--14","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*154;

);


*' @code



*### estimate standardized food requirement
p15_bodyweight(t,iso,sex,age,bmi_group15)= f15_bmi(sex,age,bmi_group15) * (p15_bodyheight(t,iso,sex,age,"preliminary")/100)**2;

*' Physical activity levels (PAL) relative to Basic metabolic rate (BMR) are
*' estimated based on physical inactivity level and assuming PALs for sedentary
*' or medium-active populations of 1.53 and 1.76.
p15_physical_activity_level(t,iso,sex,age)=
                            im_physical_inactivity(t,iso,sex,age) * 1.53
                            +(1-im_physical_inactivity(t,iso,sex,age)) * 1.76
                            ;


i15_intake(t,iso,sex,age,bmi_group15)=
                        (f15_schofield_parameters_height(sex,age, "intercept")
                        + f15_schofield_parameters_height(sex,age, "height")*p15_bodyheight(t,iso,sex,age,"preliminary")/100
                        + f15_schofield_parameters_height(sex,age, "weight")*p15_bodyweight(t,iso,sex,age,bmi_group15))
                        * p15_physical_activity_level(t,iso,sex,age);


*' Now we estimate the divergence of the BMI from the regressions
*' during the historical period for calibration purposes.
*' Within the optimization, it can however be altered to avoid shares below
*' zero or above 1.
if (sum(sameas(t_past,t),1) = 1,
   i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,bmi_regr_type15)  =
   f15_bmi_shr_regr_paras(sex,agegroup15,bmi_regr_type15,"intercept")
   + (f15_bmi_shr_regr_paras(sex,agegroup15,bmi_regr_type15,"saturation") * im_gdp_pc_ppp_iso(t,iso))
   / (f15_bmi_shr_regr_paras(sex,agegroup15,bmi_regr_type15,"halfsaturation") + im_gdp_pc_ppp_iso(t,iso));

   i15_bmi_shr_pre(t,iso,sex,agegroup15,"verylow")   =
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"low")*
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"lowsplit");

   i15_bmi_shr_pre(t,iso,sex,agegroup15,"low")   =
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"low")*
      (1-i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"lowsplit"));

   i15_bmi_shr_pre(t,iso,sex,agegroup15,"medium")   =
      (1-i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"low")
      -i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"high"))*
      (1-i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"mediumsplit"));

   i15_bmi_shr_pre(t,iso,sex,agegroup15,"mediumhigh")   =
      (1-i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"low")
      -i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"high"))*
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"mediumsplit");

   i15_bmi_shr_pre(t,iso,sex,agegroup15,"high")   =
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"high")*
      (1-i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"highsplit"));

   i15_bmi_shr_pre(t,iso,sex,agegroup15,"veryhigh")   =
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"high")*
      i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,"highsplit");


   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15)   =
   f15_bmi_shr_past(t,iso,age,sex,bmi_group15) -
   sum(agegroup2age(agegroup15,age),
       i15_bmi_shr_pre(t,iso,sex,agegroup15,bmi_group15)
   );

   i15_bmi_shr_calib_lastcalibrationyear(iso,sex,age,bmi_group15)=i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

else
*' The divergence of the BMI from the historical data is kept constant over time
*' or fadet out.
   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
   i15_bmi_shr_calib_lastcalibrationyear(iso,sex,age,bmi_group15)
   * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
);
*' pregnancy and lactation requires extra intake. We distribute the newborns among reproductive women and multuply with extra energy requirements
i15_kcal_pregnancy(t,iso)=sum(sex,im_demography(t,iso,sex,"0--4")/5) * ((40/66)*845 + (26/66)*675);

*' @stop



*###### Estimation of food demand using a first run of the food demand model with unshocked prices.

*' @code
*' Before MAgPIE is executed, the food demand model is executed the first time
*' with unshocked prices.
*' @stop

* demand for non-food products "knf" is set to 0;
vm_dem_food.fx(i,knf)=0;

*** Price-demand model is calculated the first time, using standard prices

p15_iteration_counter(t)    =0;

display "starting demand model for intitialisation run....";


* helping the solver by starting from reasonable values
* by setting real income per capita on exogenous gdp per capita
v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.fx(iso)=im_gdp_pc_ppp_iso(t,iso);

solve m15_food_demand USING nlp MAXIMIZING v15_objective ;
p15_modelstat(t) = m15_food_demand.modelstat;

display "Food Demand Model Initialisation run finished with modelstat ";
display p15_modelstat;
if(( p15_modelstat(t)) > 2 and (p15_modelstat(t) ne 7 ),
  m15_food_demand.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "Food Demand Model became infeasible already during initialisation run. Stop run.";
);

* releasing real per capita binding for later runs that include shocks

v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.up(iso)=Inf;

* saving regression outcome for height regression

p15_kcal_regr(t, iso, kfo)=v15_kcal_regr.l(iso, kfo);

* deriving calibration values

*' @code
*' Food demand and BMIis calibrated to meet the historical food demand.
*' For this purpose,
*' we calculate in the historical period with observations the residual between
*' the regression and the observation. When the historical period ends, the
*' calibarion factor is fixed at the value of the last period.
*' Additionally, we also need a balanceflow, which accounts for the mismatch
*' of demand estimates (for all countries) and the countries with FAOSTAT data
*' (only a subset), such that FAOSTAT data is still met.

if (sum(sameas(t_past,t),1) = 1,
    p15_kcal_calib(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))=0) = 0;
    p15_balanceflow_kcal_iso(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))>0) = 0;
    p15_kcal_calib(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))>0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regr.l(iso, kfo);
    p15_balanceflow_kcal_iso(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))=0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regr.l(iso, kfo);

    p15_kcal_calib_lastcalibrationyear(iso,kfo) = p15_kcal_calib(t,iso,kfo);
    p15_balanceflow_kcal_lastcalibrationyear(iso,kfo) = p15_balanceflow_kcal_iso(t,iso,kfo);

    i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                      f15_bmi_shr_past(t,iso,age,sex,bmi_group15) -
                      v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);
    i15_bmi_shr_calib_lastcalibrationyear(iso,sex,age,bmi_group15)=
                      i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

else
*' The divergence of the kcal from the historical data is eventually faded out
    p15_kcal_calib(t,iso,kfo) = p15_kcal_calib_lastcalibrationyear(iso,kfo) * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
*' The divergence of the kcal of countries with no data is kept constant over time
    p15_balanceflow_kcal_iso(t,iso,kfo) = p15_balanceflow_kcal_lastcalibrationyear(iso,kfo);

*' The divergence of the BMI from the historical data is kept constant over time
*' or fadet out.
   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                     i15_bmi_shr_calib_lastcalibrationyear(iso,sex,age,bmi_group15)
                     * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
);

*' The calib is added to the regression value
   p15_kcal_pc_iso(t,iso,kfo) =
          v15_kcal_regr.l(iso,kfo) + p15_kcal_calib(t,iso,kfo) * s15_calibrate;
   p15_bmi_shr(t,iso,sex,age,bmi_group15) =
           v15_bmi_shr_regr.l(iso,sex,age,bmi_group15)+
           i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);
*' Eventual negative values that can occur due to calib are set to zero
   p15_kcal_pc_iso(t,iso,kfo)$(p15_kcal_pc_iso(t,iso,kfo)<0) = 0;
*' The bmi shares are not allowed to exceed the bounds 0 and 1. Values are corrected to the bounds.
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

*' The country-level parameter p15_kcal_pc_iso is aggregated to
*' regional level into the parameter p15_kcal_pc. This parameter is provided
*' to constraint q15_food_demand in the MAgPIE model, which defines
*' the demand for food.
*' @stop

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


 p15_kcal_pc_initial_iso(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
 p15_kcal_pc_initial(t,i,kfo) =  p15_kcal_pc(t,i,kfo);

 o15_kcal_regr_initial(iso,kfo)=v15_kcal_regr.l(iso,kfo);

*' @code
*' Now, MAgPIE is executed.
*' @stop