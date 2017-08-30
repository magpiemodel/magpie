
if (sum(sameas(t_past,t),1) = 1,

*** get share of a staple product within total staples and livestock products, and replace zero shares with reginoal avarages
* first set it to equal shares, just in case there is no population


     i15_staples_kcal_structure_iso(t,iso,kst) =
                               sum(iso2, f15_kcal_pc_iso(t,iso2,kst)*im_pop_iso(t,iso2)) /
                               (
                                 sum((kst2,iso2),f15_kcal_pc_iso(t,iso2,kst2)*im_pop_iso(t,iso2))
                                 +10**(-5)
                               );
* 10**(-5) required to avoid unlogical division by zero error. Ask Jan P

     i15_staples_kcal_structure_iso(t,iso,kst)$(sum(kst2,f15_kcal_pc_iso(t,iso,kst2))>0) =
                               f15_kcal_pc_iso(t,iso,kst)
                               /sum(kst2,f15_kcal_pc_iso(t,iso,kst2));


     i15_livestock_kcal_structure_iso(t,iso,kap2) =
                                 sum(iso2, f15_kcal_pc_iso(t,iso2,kap2)*im_pop_iso(t,iso2))/
                                 (
                                   sum((kap3,iso2),(f15_kcal_pc_iso(t,iso2,kap3)*im_pop_iso(t,iso2)))
                                   +10**(-5)
                                 );

     i15_livestock_kcal_structure_iso(t,iso,kap2)$sum(kap3,f15_kcal_pc_iso(t,iso,kap3)>0)=
                                 f15_kcal_pc_iso(t,iso,kap2) /
                                 sum(kap3,f15_kcal_pc_iso(t,iso,kap3));
* 10**(-5) required to avoid unlogical division by zero error.

 else
* keep staples and livestock structure constant for future projections
     i15_staples_kcal_structure_iso(t,iso,kst) =i15_staples_kcal_structure_iso(t-1,iso,kst);
     i15_livestock_kcal_structure_iso(t,iso,kap2) =i15_livestock_kcal_structure_iso(t-1,iso,kap2);
 );


* demand for non-food products "knf" is set to 0;
vm_dem_food.fx(i,knf)=0;
v15_kcal_regression.fx(iso,knf)=0;

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
  abort "Food Demand Model became infeasible. Stop run.";
);

* releasing real per capita binding for later runs that include shocks

v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.up(iso)=Inf;

* deriving calibration values

if (sum(sameas(t_past,t),1) = 1,
    p15_kcal_balanceflow(t,iso,kfo) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regression.l(iso, kfo);
    p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) = p15_kcal_balanceflow(t,iso,kfo);
else
    p15_kcal_balanceflow(t,iso,kfo) = p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) * f15_kcal_balanceflow_fadeout(t,"%c15_calibscen%")
);



* add balanceflow for calibration
       p15_kcal_pc_iso(t,iso,kfo) =  v15_kcal_regression.l(iso,kfo) + p15_kcal_balanceflow(t,iso,kfo);
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


 p15_kcal_pc_initial(t,i,kfo) =  p15_kcal_pc(t,i,kfo);

 v15_kcal_pc.l(i,kfo) = p15_kcal_pc(t,i,kfo);

 p15_demand_nonfood_iso_initial(t,iso)  =  v15_demand_nonfood.l(iso);

 o15_kcal_regression_initial(iso,kfo)=v15_kcal_regression.l(iso,kfo);