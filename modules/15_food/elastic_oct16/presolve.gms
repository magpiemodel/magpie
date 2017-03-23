

vm_dem_food.fx(i,knf)=0;
v15_demand_quantity.fx(iso,knf)=0;

*** Price-demand model is calculated the first time, using standard prices

* helping the solver by starting from reasonable values
v15_income_pc_real_iso.lo(iso)=1;
v15_income_pc_real_iso.fx(iso)=i15_gdp_pc_iso(t,iso);


p15_iteration_counter(t)    =0;

display "starting demand model for intitialisation run....";

solve m15_food_demand USING nlp MAXIMIZING v15_objective ;
p15_modelstat(t) = m15_food_demand.modelstat;

display "Food Demand Model Initialisation run finished with modelstat ";
display p15_modelstat;
if(( p15_modelstat(t)) > 2 and (p15_modelstat(t) ne 7 ),
  m15_food_demand.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "Food Demand Model became unfeasible. Stop run.";
);

v15_income_pc_real_iso.lo(iso)=1;
v15_income_pc_real_iso.up(iso)=Inf;

 p15_demand_quantity_iso_initial(t,iso,kfo)=v15_demand_quantity.l(iso,kfo);
 p15_demand_nonfood_iso_initial(t,iso)=v15_demand_nonfood.l(iso);
 p15_income_pc_real_iso_initial(t,iso)=v15_income_pc_real_iso.l(iso);
* estimate regional indicators from demand model
 p15_kcal_pc_initial(t,i,kfo)$(
     sum(i_to_iso(i,iso),
       i15_pop_iso(t,iso)
     ) >0 ) =
                             sum(i_to_iso(i,iso),
                                 p15_demand_quantity_iso_initial(t,iso,kfo)* i15_pop_iso(t,iso)
                             ) / sum(i_to_iso(i,iso),
                                 i15_pop_iso(t,iso)
                             );


* First iteration is with exo demand model, assuming no price shock.
* delta in prerun is 1

 p15_delta_kcal_pc(t,i,kall) = 1;
 p15_lastiteration_delta_kcal_pc(i,kall) =1;

 v15_kcal_pc.lo(i,kall)=i15_kcal_pc_initial(t,i,kall)*p15_delta_kcal_pc(t,i,kall);
