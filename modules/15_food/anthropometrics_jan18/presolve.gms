
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


* ###### ANTHROPOMETRIC ESIMTATES
* ### Preliminary calculation of bodyweight based on food availability of last 3 timesteps
* ### This may diverge from final calcuation in the case where timesteplength exceeds 5 years
* ### As then the demand depends on the result of MAgPIE
* ### Calculations are therefore repeated after optimization

* calculations are only made after historical period. before, we use historical values

if (sum(sameas(t_past,t),1) = 1,

   p15_bodyheight(t,iso,sex,age_group,estimates15) = f15_bodyheight(t,iso,sex,age_group);


else

    p15_bodyheight(t,iso,sex,age_group,"preliminary") = p15_bodyheight(t-1,iso,sex,age_group,"final");
    p15_kcal_growth_food(t,iso,age_groups_underaged15) = p15_kcal_growth_food(t-1,iso,age_groups_underaged15);

    s15_count=m_yeardiff(t);
* avoid fake 1yr timestep in 1995
    if(s15_count<5,s15_count=5);
    For (s15_count = 1 to (m_yeardiff(t)/5),

* circular move of age_groups by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
          p15_bodyheight(t,iso,sex,age_group++1,"preliminary") = p15_bodyheight(t,iso,sex,age_group,"preliminary");

* replace age groups of 18 year olds
          p15_bodyheight(t,iso,"F","15--19","preliminary") =
                 126.4*
                 (sum(age_groups_underaged15,
                   p15_kcal_growth_food(t,iso,age_groups_underaged15)
                 )/3)**0.03464
                 ;
          p15_bodyheight(t,iso,"M","15--19","preliminary") =
                 131.8*
                 (sum(age_groups_underaged15,
                   p15_kcal_growth_food(t,iso,age_groups_underaged15)
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



*### estimate standardized food requirement
p15_bodyweight_healthy(t,iso,sex,age_group)= 22.5* (p15_bodyheight(t,iso,sex,age_group,"preliminary")/100)**2;
p15_bodyweight_healthy(t,iso,sex,"0--4")   = 16*   (p15_bodyheight(t,iso,sex,"0--4","preliminary")   /100)**2;
p15_bodyweight_healthy(t,iso,sex,"5--9")   = 16*   (p15_bodyheight(t,iso,sex,"5--9","preliminary")   /100)**2;
p15_bodyweight_healthy(t,iso,sex,"10--14") = 18*   (p15_bodyheight(t,iso,sex,"10--14","preliminary") /100)**2;
p15_bodyweight_healthy(t,iso,sex,"15--19") = 21*   (p15_bodyheight(t,iso,sex,"15--19","preliminary") /100)**2;

*physical activity levels in PAL relative to Basic metabolic rate (BMR)
p15_physical_activity_level(t,iso,sex,age_group)=
                            im_physical_inactivity(t,iso,sex,age_group) * 1.53
                            +(1-im_physical_inactivity(t,iso,sex,age_group)) * 1.76
                            ;
p15_kcal_requirement(t,iso,sex,age_group)=
                        (f15_schofield_parameters_height(sex,age_group, "intercept")
                        + f15_schofield_parameters_height(sex,age_group, "height")*p15_bodyheight(t,iso,sex,age_group,"preliminary")/100
                        + f15_schofield_parameters_height(sex,age_group, "weight")*p15_bodyweight_healthy(t,iso,sex,age_group))
                        * p15_physical_activity_level(t,iso,sex,age_group);

* pregnancy and lactation requires extra intake. We distribute the newborns among reproductive women and multuply with extra energy requirements
p15_kcal_pregnancy(t,iso,sex,age_group)=0;
p15_kcal_pregnancy(t,iso,"F",reproductive)$sum(reproductive2, im_demography(t,iso,"F",reproductive2)>0) =
                   sum(sex,im_demography(t,iso,sex,"0--4")/5)/
                   sum(reproductive2, im_demography(t,iso,"F",reproductive2))
                   * ((40/66)*845 + (26/66)*675)
                   ;



if (sum(sameas(t_past,t),1) = 1,

   p15_bodyheight(t,iso,sex,age_group,estimates15) = f15_bodyheight(t,iso,sex,age_group);

   p15_intake_balanceflow(t,iso,sex,age_group) =
      f15_intake_pc_observed_iso(t,iso,sex,age_group) -
      (p15_kcal_requirement(t,iso,sex,age_group)+ p15_kcal_pregnancy(t,iso,sex,age_group))*
      (
          f15_intake_regression_parameters(sex,age_group,"saturation")*im_gdp_pc_ppp_iso(t,iso)
          /(f15_intake_regression_parameters(sex,age_group,"halfsaturation")+im_gdp_pc_ppp_iso(t,iso))
          +f15_intake_regression_parameters(sex,age_group,"intercept")
      );

   p15_intake_balanceflow_lastcalibrationyear(iso,sex,age_group)=p15_intake_balanceflow(t,iso,sex,age_group);
else
    p15_intake_balanceflow(t,iso,sex,age_group) =  p15_intake_balanceflow_lastcalibrationyear(iso,sex,age_group) * f15_kcal_balanceflow_fadeout(t,"%c15_calibscen%");
);


*###### Estimation of food demand using a first run of the food demand model with unshocked prices.

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

p15_kcal_regression(t, iso, kfo)=v15_kcal_regression.l(iso, kfo);

* deriving calibration values



if (sum(sameas(t_past,t),1) = 1,
    p15_kcal_balanceflow(t,iso,kfo)$(f15_kcal_pc_iso(t,iso,kfo)=0) = 0;
    p15_kcal_balanceflow(t,iso,kfo)$(f15_kcal_pc_iso(t,iso,kfo)>0) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regression.l(iso, kfo);
    p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) = p15_kcal_balanceflow(t,iso,kfo);
else
    p15_kcal_balanceflow(t,iso,kfo) = p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) * f15_kcal_balanceflow_fadeout(t,"%c15_calibscen%");
);



* add balanceflow for calibration
       p15_kcal_pc_iso(t,iso,kfo) =  v15_kcal_regression.l(iso,kfo) + p15_kcal_balanceflow(t,iso,kfo) * s15_calibrate;
* set negative values that can occur due to balanceflow to zero
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


 p15_kcal_pc_initial_iso(t,iso,kfo) = p15_kcal_pc_iso(t,iso,kfo);
 p15_kcal_pc_initial(t,i,kfo) =  p15_kcal_pc(t,i,kfo);

 o15_kcal_regression_initial(iso,kfo)=v15_kcal_regression.l(iso,kfo);