*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* retrieving interfaces from MAgPIE
* calculate prices for providing 1 kcal per day of one commodity

  if (magpie.modelstat = NA,
    display "Coupling: Reading exogenous prices as MAgPIE has not (yet) been run";
    q15_food_demand.m(i,kfo)=0;
    p15_prices_kcal(t,iso,kfo,curr_iter15)=i15_prices_initial_kcal(iso,kfo)*f15_price_index(t);
  else
*' @code
*' After one time step of MAgPIE is executed, the shadow prices of the food demand
*' constraint are fed back into the food demand module, and the food demand
*' module is executed once again.
    display "Coupling: Reading out marginal costs from MAgPIE";
    p15_prices_kcal(t,iso,kfo,curr_iter15)=sum(i_to_iso(i,iso), q15_food_demand.m(i,kfo));
*' @stop
  );

*' If `s15_elastic_demand` is 0, MAgPIE is not executed again for this time step.
if (s15_elastic_demand = 1 AND m_year(t) > sm_fix_SSP2,
  display "elastic demand model is activated";

  option nlp = conopt4;
  option threads = 1;

* A new iteration is started
  p15_iteration_counter(t) = p15_iteration_counter(t) + 1;
* The set current iter includes only one element with the set element
* of the current iteration, e.g. "iter2"
  curr_iter15(iter15) = no;
  curr_iter15(iter15)$(ord(iter15)=p15_iteration_counter(t)) = yes;
* Now we also define a set for the previous iteration
  prev_iter15(iter15) = no;
  prev_iter15(iter15)$(ord(iter15)=p15_iteration_counter(t)-1) = yes;

*' @code
  display "starting m15_food_demand in iteration number ", p15_iteration_counter;

  solve m15_food_demand USING nlp MAXIMIZING v15_objective;
*' @stop in

* in case of problems try CONOPT3
  if(m15_food_demand.modelstat > 2,
     display "Modelstat > 2 | Retry solve with CONOPT3";
     option nlp = conopt3;
     solve m15_food_demand USING nlp MAXIMIZING v15_objective;
     option nlp = conopt4;
  );

  p15_modelstat(t) = m15_food_demand.modelstat;

  display "Food Demand Model finished with modelstat ";
  display p15_modelstat;

  if(p15_modelstat(t) > 2 AND p15_modelstat(t) ne 7,
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



  p15_delta_income(t,i,curr_iter15) = p15_income_pc_real_ppp(t,i) /
            ( sum(i_to_iso(i,iso),
                               im_gdp_pc_ppp_iso(t,iso)
                               * im_pop_iso(t,iso)
                             ) / sum(i_to_iso(i,iso),
                                 im_pop_iso(t,iso))
                        );


* estimate convergence measure for deciding to stop iteration


  p15_convergence_measure(t,curr_iter15) =smax(i,
                              abs(p15_delta_income(t,i,curr_iter15) / sum(prev_iter15,p15_delta_income(t,i,prev_iter15))- 1)
                            );

  display "convergence measure:",p15_convergence_measure;

*' @code

*' It is checked whether MAgPIE and the
*' food demand model have reached sufficient convergence. The criterion for this
*' is whether the real income in the food demand model has changed in any region
*' by more than `s15_convergences_measure` relative to the last iteration due to
*' changes in food prices from MAgPIE. Moreover, the model aborts when the
*' number of iterations reaches `s15_maxiter`.
*' As long as the iteration continues, the food prices are transferred from
*' MAgPIE to the food demand model, and the food demand is transferred from
*' the food demand model to MAgPIE.
*' @stop


  if ((sum(curr_iter15,p15_convergence_measure(t,curr_iter15)) > s15_convergence and p15_iteration_counter(t) <= s15_maxiter),

        display "convergence between MAgPIE and Food Demand Model not yet reached";
        display "starting magpie in iteration number ", p15_iteration_counter;
        sm_intersolve=0;
        s15_run_diet_postprocessing=1;

  elseif(p15_iteration_counter(t) > s15_maxiter),
      sm_intersolve=1;
      s15_run_diet_postprocessing=0;
      display "Warning: convergence between MAgPIE and Food Demand Model not reached after ",p15_iteration_counter," iterations. Continue to next time step!";
  else
       sm_intersolve=1;
       s15_run_diet_postprocessing=0;
       display "Success: convergence between MAgPIE and Food Demand Model reached.";
       display "requiring ",p15_iteration_counter," runs of food demand model, ";
       display "and one run less with MAgPIE.";
* set back convergence indicators for next timestep
  );

* if the food demand model is not run again, also postprocessing is not
* executed again.
else
  display "exogenous demand information is used" ;
  s15_run_diet_postprocessing=0;
);

* Postprocessing of diets: calibration, exogenous scenario modifications and
* aggregation to regional level.
* As this occurs twice (in presolve and intersolve), it is here included as
* macro. As include comments are not allowed within if statements, we pass the
* information whether postprocessing shall be executed to the macro within
* the parameter s15_run_diet_postprocessing. It is checked within the macro
* whether it shall be executed again.
$include "./modules/15_food/anthro_iso_jun22/exodietmacro.gms";

if (s15_run_diet_postprocessing = 1 ,
  if (p15_modelstat(t) <= 2,
     put_utility 'shell' / 'mv -f m15_food_demand_p.gdx m15_food_demand_' t.tl:0'.gdx';
  );
);
s15_run_diet_postprocessing=1;
