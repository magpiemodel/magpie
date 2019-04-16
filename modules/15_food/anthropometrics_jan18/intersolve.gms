*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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

