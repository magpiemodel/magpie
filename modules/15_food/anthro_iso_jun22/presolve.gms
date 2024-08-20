*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



if(m_year(t) <= sm_fix_SSP2,
 i15_dem_intercept(iso,regr15)   = f15_demand_paras(regr15,"SSP2","intercept");
 i15_dem_saturation(iso,regr15)  = f15_demand_paras(regr15,"SSP2","saturation");
 i15_dem_halfsat(iso,regr15)     = f15_demand_paras(regr15,"SSP2","halfsaturation");
 i15_dem_nonsat(iso,regr15)      = f15_demand_paras(regr15,"SSP2","non_saturation");
else
 i15_dem_intercept(iso,regr15)   = f15_demand_paras(regr15,"%c15_food_scenario%","intercept")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","intercept")*(1-p15_country_dummy(iso));
 i15_dem_saturation(iso,regr15)  = f15_demand_paras(regr15,"%c15_food_scenario%","saturation")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","saturation")*(1-p15_country_dummy(iso));
 i15_dem_halfsat(iso,regr15)     = f15_demand_paras(regr15,"%c15_food_scenario%","halfsaturation")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","halfsaturation")*(1-p15_country_dummy(iso));
 i15_dem_nonsat(iso,regr15)      = f15_demand_paras(regr15,"%c15_food_scenario%","non_saturation")*p15_country_dummy(iso)
                                 + f15_demand_paras(regr15,"%c15_food_scenario_noselect%","non_saturation")*(1-p15_country_dummy(iso));
);

option nlp = conopt4;
option threads = 1;

*' @code
*' Within the major food groups determined by the regressions
*' (animal calories, empty calories, fruits, vegetable and nut calories as well as staple calories),
*' the relative share of individual products (e.g. eggs within animal calories)
*' is assumed to be constant. An exception is the demand for ruminant meat,
*' which declines in the course of the century at the cost of chicken meat.
*' @stop

if (sum(sameas(t_past,t),1) = 1,

*** Calculate the share of individual food products within major food groups, and replace zero shares with regional averages
* First set it to equal shares, just in case there is no population


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
                               /sum(kfo_pf2,f15_kcal_pc_iso(t,iso,kfo_pf2)
                               );

     i15_staples_kcal_structure_iso(t,iso,kfo_st) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kfo_st)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kfo_st2,iso2),f15_kcal_pc_iso(t,iso2,kfo_st2)*im_pop_iso(t,iso2))
                                 +10**(-5)
*                                10**(-5) required to avoid unlogical division by zero error. Ask Jan P
                               );

     i15_staples_kcal_structure_iso(t,iso,kfo_st)$(sum(kfo_st2,f15_kcal_pc_iso(t,iso,kfo_st2))>0) =
                               f15_kcal_pc_iso(t,iso,kfo_st)
                               /sum(kfo_st2,f15_kcal_pc_iso(t,iso,kfo_st2)
                               );


 else
* Assumptions on future calorie structure within food groups for future projections:
     i15_staples_kcal_structure_iso(t,iso,kfo_st) =i15_staples_kcal_structure_iso(t-1,iso,kfo_st);
     i15_processed_kcal_structure_iso(t,iso,kfo_pf) =i15_processed_kcal_structure_iso(t-1,iso,kfo_pf);
     i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap) = i15_livestock_kcal_structure_iso_raw(t-1,iso,kfo_ap);
     i15_livestock_kcal_structure_iso(t,iso,kfo_ap)     = i15_livestock_kcal_structure_iso_raw(t,iso,kfo_ap);
     i15_livestock_kcal_structure_iso(t,iso,"livst_chick") =
                                 i15_livestock_kcal_structure_iso_raw(t,iso,"livst_chick")
                                 + i15_livestock_kcal_structure_iso_raw(t,iso,"livst_rum") * (1-i15_rum_share_fadeout(t,iso));
    i15_livestock_kcal_structure_iso(t,iso,"livst_rum") =
                                 i15_livestock_kcal_structure_iso_raw(t,iso,"livst_rum") * i15_rum_share_fadeout(t,iso);

* Substitute milk demand in India with chicken, egg and fish (equally distributed) because milk demand in India shows an implausible increase
      i15_livestock_kcal_structure_iso(t,"IND","livst_milk") =
                                 i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * i15_milk_share_fadeout_india(t);
      i15_livestock_kcal_structure_iso(t,"IND","livst_chick") =
                  i15_livestock_kcal_structure_iso(t,"IND","livst_chick")
                  + i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * (1-i15_milk_share_fadeout_india(t)) * 1/3;
      i15_livestock_kcal_structure_iso(t,"IND","livst_egg") =
                  i15_livestock_kcal_structure_iso(t,"IND","livst_egg")
                  + i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * (1-i15_milk_share_fadeout_india(t)) * 1/3;
      i15_livestock_kcal_structure_iso(t,"IND","fish") =
                  i15_livestock_kcal_structure_iso(t,"IND","fish")
                  + i15_livestock_kcal_structure_iso_raw(t,"IND","livst_milk") * (1-i15_milk_share_fadeout_india(t)) * 1/3;
 );


*' @code
*' The calculations are executed in the following order:
*'
*' In the beginning of each time step, the body height is estimated based on the diets
*' of the previous 15 years. In case that the time step length exceeds 5 years,
*' the consumption is extrapolated using the last two time steps.
*' Body height is estimated using the consumption of proteins and fats, in our case
*' the foodgroups animal products, pulses and oils.
*' To estimate the body size of underaged (0-14 years), we scale the WHO body height
*' recommendations for underaged with the divergence of the 15-19 year old.
*' The body height estimates are repeated again at the end of the time step to improve
*' the results of the extrapolation for cases where the time step length exceeds 5 years.
*' @stop

* ###### ANTHROPOMETRIC ESTIMATES
* ### Preliminary calculation of body height and weight based on food availability of last 3 timesteps.
* ### This may diverge from final calculation in the case where timestep length exceeds 5 years
* ### as then the demand depends on the result of MAgPIE.
* ### Calculations are therefore repeated after optimization.

* Calculations are only made after historical period. Before, we use historical values.

if (sum(sameas(t_past,t),1) = 1,

   p15_bodyheight(t,iso,sex,age,estimates15) = f15_bodyheight(t,iso,sex,age);


else

    p15_bodyheight(t,iso,sex,age,"preliminary") = p15_bodyheight(t-1,iso,sex,age,"final");
    p15_kcal_growth_food(t,iso,underaged15) = p15_kcal_growth_food(t-1,iso,underaged15);




    s15_yeardiff = m_yeardiff(t)/5;
* avoid fake 1yr timestep in 1995
    if(s15_yeardiff<1,s15_yeardiff=1);

    For (s15_count = 1 to s15_yeardiff,


* circular move of age by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
          p15_bodyheight(t,iso,sex,age++1,"preliminary") = p15_bodyheight(t,iso,sex,age,"preliminary");

* replace age groups of 18 year old
          p15_bodyheight(t,iso,sex,"15--19","preliminary") =
                 f15_bodyheight_regr_paras(sex,"slope")*
                 (sum(underaged15,
                   p15_kcal_growth_food(t,iso,underaged15)
                 )/3)**f15_bodyheight_regr_paras(sex,"exponent")
                 ;

     );
*adjust body height of kids proportional to over18 population
     p15_bodyheight(t,iso,"M","0--4","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*92;
     p15_bodyheight(t,iso,"M","5--9","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*125;
     p15_bodyheight(t,iso,"M","10--14","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/176*152;

     p15_bodyheight(t,iso,"F","0--4","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*91;
     p15_bodyheight(t,iso,"F","5--9","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*124;
     p15_bodyheight(t,iso,"F","10--14","preliminary")=p15_bodyheight(t,iso,"M","15--19","preliminary")/163*154;

);


*' @code



*### Estimate standardized food requirements
p15_bodyweight(t,iso,sex,age,bmi_group15)= f15_bmi(sex,age,bmi_group15) * (p15_bodyheight(t,iso,sex,age,"preliminary")/100)**2;

*' Physical activity levels (PAL) relative to the basic metabolic rate (BMR) are
*' estimated based on physical inactivity levels, assuming PALs for sedentary
*' and medium-active populations of 1.53 and 1.76 respectively:
p15_physical_activity_level(t,iso,sex,age)=
                            im_physical_inactivity(t,iso,sex,age) * 1.53
                            +(1-im_physical_inactivity(t,iso,sex,age)) * 1.76
                            ;

p15_intake(t,iso,sex,age,bmi_group15)=
                        (f15_schofield(sex,age, "intercept")
                        + f15_schofield(sex,age, "slope")*p15_bodyweight(t,iso,sex,age,bmi_group15))
                        * p15_physical_activity_level(t,iso,sex,age);


*' Pregnancy and lactation require additional food intake. To account for this,
*' newborns are distributed among reproductive women in a population. This number
*' is then multiplied with the extra energy requirements:
i15_kcal_pregnancy(t,iso)=sum(sex,im_demography(t,iso,sex,"0--4")/5) * ((40/66)*845 + (26/66)*675);

*' @stop



*###### Estimation of food demand using a first run of the food demand model with unshocked prices.

*' @code
*' Before MAgPIE is executed, the food demand model is executed, at first
*' without price shocks.
*' @stop

* demand for non-food products "knf" is set to 0;
vm_dem_food.fx(i,knf)=0;

*** Food demand model is calculated the first time for the current time step, using standard prices

* activating the first iteration
p15_iteration_counter(t) = 1;

* The set curr_iter15 includes only one element with the set element
* of the current iteration, e.g. "iter2"
curr_iter15(iter15) = no;
curr_iter15(iter15)$(ord(iter15)=p15_iteration_counter(t)) = yes;

p15_delta_income(t,i,curr_iter15) = 1;

display "starting demand model for initialisation run....";


* helping the solver by starting from reasonable values
* by setting real income per capita on exogenous gdp per capita
v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.fx(iso)=im_gdp_pc_ppp_iso(t,iso);

solve m15_food_demand USING nlp MAXIMIZING v15_objective;

* in case of problems try CONOPT3
if(m15_food_demand.modelstat > 2,
  display "Modelstat > 2 | Retry solve with CONOPT3";
  option nlp = conopt3;
  solve m15_food_demand USING nlp MAXIMIZING v15_objective;
  option nlp = conopt4;
);

p15_modelstat(t) = m15_food_demand.modelstat;

display "Food Demand Model Initialisation run finished with modelstat ";
display p15_modelstat;

if(p15_modelstat(t) > 2 AND p15_modelstat(t) ne 7,
  m15_food_demand.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "Food Demand Model became infeasible already during initialisation run. Stop run.";
);

* releasing real income per capita binding for later runs that include shocks
v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.up(iso)=Inf;

* deriving calibration values

*' @code
*' Per capita food demand and BMI shares are calibrated so that historical data
*' are met. For this purpose, the residual between the regression fit and the
*' observation is calculated for the historical period. When the historical period
*' ends, the calibration factor is fixed at the value of the last historical time
*' step. Additionally, a second calibration is required to meet the world totals
*' of FAOSTAT food demand for different foods. While the food demand model estimates
*' the demand for all countries of the world, FAOSTAT only covers a subset of
*' countries. To match FAOSTAT totals, the food demand of countries not included
*' in FAOSTAT is calibrated to zero. As this calibration is done ex-post, food
*' demand estimates can still be used for all countries, but MAgPIE only considers
*' demand from FAOSTAT countries.

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
*' historical data is kept constant or faded out.
    p15_kcal_calib(t,iso,kfo) = p15_kcal_calib_lastcalibyear(iso,kfo) * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
*' The divergence of the kcal of countries with no FAOSTAT data is kept constant
*' over time.
    p15_balanceflow_kcal_iso(t,iso,kfo) = p15_balanceflow_kcal_lastcalibyear(iso,kfo);

*' Depending on the scenario switch c15_calibscen, the divergence of the BMI shares from the
*' historical data is kept constant over time or faded out.
   i15_bmi_shr_calib(t,iso,sex,age,bmi_group15) =
                     i15_bmi_shr_calib_lastcalibyear(iso,sex,age,bmi_group15)
                     * f15_kcal_calib_fadeout(t,"%c15_calibscen%");
);



*###############################################################################
* ###### Food substitution scenarios, same as in intersolve
s15_run_diet_postprocessing = 1;
$include "./modules/15_food/anthro_iso_jun22/exodietmacro.gms";


* some calculations for postprocessing and other modules
p15_kcal_pc_initial_iso(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
pm_kcal_pc_initial(t,i,kfo) =  p15_kcal_pc(t,i,kfo);
o15_kcal_regr_initial(t,iso,kfo) = v15_kcal_regr.l(iso,kfo);


*' @stop

*###############################################################################




*' @code
*' Now, MAgPIE is executed.
*' @stop
