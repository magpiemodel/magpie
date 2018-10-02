option nlp = conopt4


*' @code
*' Within the major foodgroups determined by the regressions
*' (animal calories, empty calories, fruits, vegetable and nut calories as well as staple calories),
*' the relative share of individual products (e.g. eggss with animal calories)
*' is assumed to be constant. An exception is the demand for ruminant meat,
*' which declines in the course of the century at the cost of chicken meat.
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
*' In the beginning of each time step, the body height is estimated based on the diets
*' of the previous 15 years. In case that the time step length exceed 5 years, the consumption
*' is extrapolated using the last two time steps.
*' Body height is estimated using the consumption of proteins and fats, in our case
*' the foodgroups animal products, pulses and oils.
*' To estimate the body size of underaged (0-14 years), we scale the WHO body height
*' recommendations for underaged with the divergence of the 15-19 year olds.
*' The body height estimates are repeated again at the end of the time step to improve
*' the results of the extrapolation for cases where the time step length exceeds 5 years.
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
                 )/3)**0.03467
                 ;
          p15_bodyheight(t,iso,"M","15--19","preliminary") =
                 131.8*
                 (sum(underaged15,
                   p15_kcal_growth_food(t,iso,underaged15)
                 )/3)**0.03978
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

*' Physical activity levels (PAL) relative to the basic metabolic rate (BMR) are
*' estimated based on physical inactivity levels, assuming PALs for sedentary
*' and medium-active populations of 1.53 and 1.76 respectively.
p15_physical_activity_level(t,iso,sex,age)=
                            im_physical_inactivity(t,iso,sex,age) * 1.53
                            +(1-im_physical_inactivity(t,iso,sex,age)) * 1.76
                            ;


i15_intake(t,iso,sex,age,bmi_group15)=
                        (f15_schofield(sex,age, "intercept")
                        + f15_schofield(sex,age, "slope")*p15_bodyweight(t,iso,sex,age,bmi_group15))
                        * p15_physical_activity_level(t,iso,sex,age);


*' Then, the divergence of the BMI from the regression during the historical
*' period is estimated for calibration purposes.

if (sum(sameas(t_past,t),1) = 1,
   i15_bmi_shr_regr_pre(t,iso,sex,agegroup15,bmi_tree15)  =
   f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"intercept")
   + (f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"saturation") * im_gdp_pc_ppp_iso(t,iso))
   / (f15_bmi_shr_paras(sex,agegroup15,bmi_tree15,"halfsaturation") + im_gdp_pc_ppp_iso(t,iso));

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

   i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)=i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

else
*' The divergence of the BMI from the historical data is kept constant over time
*' or fades out.
   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
   i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)
   * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
);
*' Pregnancy and lactation requires additonal food intakes. To account for this,
*' newborns are distributed among reproductive women in a population. This number
*' is then multiplied with the extra energy requirements
i15_kcal_pregnancy(t,iso)=sum(sex,im_demography(t,iso,sex,"0--4")/5) * ((40/66)*845 + (26/66)*675);

*' @stop



*###### Estimation of food demand using a first run of the food demand model with unshocked prices.

*' @code
*' Before MAgPIE is executed, the food demand model is executed, at first
*' without price shocks.
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
*' Food demand and BMIs are calibrated so that historical food demand is met.
*' For this purpose, the residual between the regression fit and the observation
*' is calculated for the historical period. When the historical period ends, the
*' calibarion factor is fixed at the value of the last period.
*' Additionally, a second calibration is requrired to meet the FAOSTAT fooduse
*' demand. While the food demand model estimates the demand for all countries
*' of the world, FAOSTAT only has a subset of countries. To match FAOSTAT totals,
*' the food demand of these countries is calibrated to zero. As this calibration
*' is done ex-post, food demand estimates can still be used for all countries,
*' but MAgPIE only considers demand from FAOSTAT countries.

if (sum(sameas(t_past,t),1) = 1,
    p15_kcal_calib(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))=0) = 0;
    p15_balanceflow_kcal_iso(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))>0) = 0;
    p15_kcal_calib(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))>0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regr.l(iso, kfo);
    p15_balanceflow_kcal_iso(t,iso,kfo)$(sum(kfo2,f15_kcal_pc_iso(t,iso,kfo2))=0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regr.l(iso, kfo);

    p15_kcal_calib_lastcalibyear(iso,kfo) = p15_kcal_calib(t,iso,kfo);
    p15_balanceflow_kcal_lastcalibyear(iso,kfo) = p15_balanceflow_kcal_iso(t,iso,kfo);

    i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                      f15_bmi_shr_past(t,iso,age,sex,bmi_group15) -
                      v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);
    i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)=
                      i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

else
*' Depending on the scenario switch c15_calibscen, the divergence of the demand from the
*' historical data is kept constant or eventually faded out
    p15_kcal_calib(t,iso,kfo) = p15_kcal_calib_lastcalibyear(iso,kfo) * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
*' The divergence of the kcal of countries with no FAOSTAT data is kept constant
*' over time.
    p15_balanceflow_kcal_iso(t,iso,kfo) = p15_balanceflow_kcal_lastcalibyear(iso,kfo);

*' Depending on the scenario switch c15_calibscen, the divergence of the BMI from the historical
*' data is kept constant over time or fadet out.
   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                     i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)
                     * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
);

*' The calibration factor is added to the regression value.
   p15_kcal_pc_iso(t,iso,kfo) =
          v15_kcal_regr.l(iso,kfo) + p15_kcal_calib(t,iso,kfo) * s15_calibrate;
*' Negative values that can possibly occur due to calibration, are set to zero.
   p15_kcal_pc_iso(t,iso,kfo)$(p15_kcal_pc_iso(t,iso,kfo)<0) = 0;

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
 pm_kcal_pc_initial(t,i,kfo) =  p15_kcal_pc(t,i,kfo);

 o15_kcal_regr_initial(iso,kfo)=v15_kcal_regr.l(iso,kfo);

* Finally, we calibrate countries with zero food demand according to FAOSTAT
* down to zero to match FAO values-
* Values are rounded to avoid path dependencies of MAgPIE solver
 p15_kcal_pc_calibrated(t,i,kfo)=p15_kcal_pc(t,i,kfo)+p15_balanceflow_kcal(t,i,kfo);
 p15_kcal_pc_calibrated(t,i,kfo)=round(p15_kcal_pc_calibrated(t,i,kfo),2);
 p15_kcal_pc_calibrated(t,i,kfo)$(p15_kcal_pc_calibrated(t,i,kfo)<0)=0;

*' @code
*' Now, MAgPIE is executed.
*' @stop