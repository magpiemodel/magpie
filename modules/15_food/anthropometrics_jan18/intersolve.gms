option nlp = conopt

* retrieving interfaces from MAgPIE
*calculate prices for providing 1 kcal per day of one commodity

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

 p15_delta_income_pc_real_ppp(t,i) = p15_income_pc_real_ppp(t,i) / im_gdp_pc_ppp(t,i);

* estimate convergence measure for deciding to stop iteration


 p15_convergence_measure(t) =smax(i,
                              abs(p15_delta_income_pc_real_ppp(t,i) / p15_lastiteration_delta_income_pc_real_ppp(i)- 1)
                            );


* keeping current deltas for estimating convergence in next timestep
 p15_lastiteration_delta_income_pc_real_ppp(i) = p15_delta_income_pc_real_ppp(t,i);



display "finished iteration number ", p15_iteration_counter;
display "convergence measure:",p15_convergence_measure;

if (s15_elastic_demand =1,
  display "elastic demand model is activated";
  if ((p15_convergence_measure(t) > s15_convergence and p15_iteration_counter(t) <= s15_maxiter),

        display "convergence between MAgPIE and Food Demand Model not yet reached";
        sm_intersolve=0;

* saving regression outcome for postprocessing

         p15_kcal_regression(t, iso, kfo)=v15_kcal_regression.l(iso, kfo);

* estimating calibrated values for height regression
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



*** estimate bodyheight

if(ord(t)>1,
* start from bodyheight structure of last period
   p15_bodyheight(t,iso,sex,age_group,"final") = p15_bodyheight(t-1,iso,sex,age_group,"final");
   p15_kcal_growth_food(t,iso,age_groups_underaged15) = p15_kcal_growth_food(t-1,iso,age_groups_underaged15);
);

s15_count=m_yeardiff(t);
if(s15_count<5,s15_count=5);

For (s15_count = 1 to (m_yeardiff(t)/5),

* circular move of age_groups by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
   p15_bodyheight(t,iso,sex,age_group++1,"final") = p15_bodyheight(t,iso,sex,age_group,"final");

*  move on consumption agegroups by 5 years
   p15_kcal_growth_food(t,iso,age_groups_underaged15++1)=
            p15_kcal_growth_food(t,iso,age_groups_underaged15);

*  consumption is calculated as linear interpolation between timesteps
   p15_kcal_growth_food(t,iso,"0--4") =
            sum(growth_food15,
                p15_kcal_pc_iso(t,iso,growth_food15) * (s15_count / (m_yeardiff(t)/5))
                + p15_kcal_pc_iso(t-1,iso,growth_food15) * (1 - s15_count / (m_yeardiff(t)/5))
            );

   p15_bodyheight(t,iso,"F","15--19","final") =
                     126.4*
                     (sum(age_groups_underaged15,
                       p15_kcal_growth_food(t,iso,age_groups_underaged15)
                     )/3)**0.03464
                     ;
   p15_bodyheight(t,iso,"M","15--19","final") =
                     131.8*
                     (sum(age_groups_underaged15,
                       p15_kcal_growth_food(t,iso,age_groups_underaged15)
                     )/3)**0.03975
                     ;

);

*adjust body weight of kids proportional to over18 population
p15_bodyheight(t,iso,"M","0--4","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*92;
p15_bodyheight(t,iso,"M","5--9","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*125;
p15_bodyheight(t,iso,"M","10--14","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*152;

p15_bodyheight(t,iso,"F","0--4","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*91;
p15_bodyheight(t,iso,"F","5--9","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*124;
p15_bodyheight(t,iso,"F","10--14","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*154;


if (sum(sameas(t_past,t),1) = 1,
* for historical period only use estimate to calibrate balanceflow but use historical data for values
  p15_bodyheight_balanceflow(t,iso,sex,age_groups_new_estimated15) = f15_bodyheight(t,iso,sex,age_groups_new_estimated15) - p15_bodyheight(t,iso,sex,age_groups_new_estimated15,"final");
  p15_bodyheight(t,iso,sex,age_groups_new_estimated15,"final") = f15_bodyheight(t,iso,sex,age_groups_new_estimated15);
else
  p15_bodyheight_balanceflow(t,iso,sex,age_groups_new_estimated15)=p15_bodyheight_balanceflow(t-1,iso,sex,age_groups_new_estimated15);
  p15_bodyheight(t,iso,sex,age_groups_new_estimated15,"final")=p15_bodyheight(t,iso,sex,age_groups_new_estimated15,"final")+p15_bodyheight_balanceflow(t,iso,sex,age_groups_new_estimated15)*s15_calibrate;
);
