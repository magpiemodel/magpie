*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$title demand_model_standalone

$offupper
$offsymxref
$offsymlist
$offlisting

$setglobal c_timesteps  3

scalars sm_use_gdx   use of gdx files                                      / 2 /
        sm_maxiter   maximal solve iterations if modelstat is > 2        / 100 /
        s_maxdiff    max diff between lp and nlp solution  (mio. USD)   / 1000 /
        sm_invest_horizon investment time horizon (years)                 / 30 /
;

*******************************END MODULE SETUP*********************************

***************************PREDEFINED MACROS************************************
$include "./core/macros.gms"
********************************************************************************
*************************BASIC SETS INDICES***********************************
$include "./core/sets.gms"
$include "./modules/15_food/elastic_oct16/sets.gms"


sets
   kap(kall)
   /
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk, fish
   /

   kli(kap)
   /
   livst_rum,livst_pig,livst_chick, livst_egg, livst_milk
   /
;

********************************************************************************
**********INTRODUCE CALCULATION PARAMETERS, VARIABLES AND EQUATIONS*************
$include "./core/declarations.gms"
$include "./modules/15_food/elastic_oct16/declarations.gms"
********************************************************************************

*activate stanalone mode
s15_standalone =1;

*****************************IMPORT DATA FILES**********************************
$include "./modules/15_food/elastic_oct16/input.gms"
********************************************************************************
********************OBJECTIVE FUNCTION & CONSTRAINTS****************************
$include "./modules/15_food/elastic_oct16/equations.gms"
********************************************************************************

model magpiemini /
q15_food_demand,
q15_aim_standalone/;




option lp         = cplex ;
option qcp        = cplex ;
option nlp        = conopt ;
option iterlim    = 1000000 ;
option reslim     = 1000000 ;
option sysout     = Off ;
option limcol     = 0 ;
option limrow     = 0 ;
option decimals   = 3 ;
option savepoint  = 1 ;

*****************************VARIABLE SCALING***********************************
$include "./modules/15_food/elastic_oct16/scaling.gms"
********************************************************************************


********************************************************************************
****************************PREPROCESSING START*********************************
*In this section everything is calculated that is not influenced by the
*optimization process. Hence these lines CAN INFLUENCE the optimization process
*but CANNOT BE INFLUENCED by it.


$include "./modules/15_food/elastic_oct16/preloop.gms"

*****************************PREPROCESSING END**********************************
********************************************************************************

*create dummy file (this is necessary to be able to use put_utility and it has
*to be done here because a file declaration cannot be inside a loop
file dummy; dummy.pw=2000; put dummy;

********************************************************************************
************************OPTIMIZATION PROCESS START******************************
*This section contains only sourcecode that is directly connected to the
*optimization process. That means that everything on the following lines
*INFLUENCES and IS INFLUENCED by the optimization process (except the
*redefinition on preprocessed data).
*Hence one can describe this section together with the constraints section
*as "model-core".

* clear ct set
ct(t) = no;

***************************TIMESTEP LOOP START**********************************


loop (t,

* set ct to current time period
      ct(t) = yes;

      display "Year";
      display ct;

* redefine preprocessed data using only the information for the current time step
* this is necessary because every parameter used in a constraint must not
* contain the time t explicitly (parameters are marked with "c" for "current").



$include "./modules/15_food/elastic_oct16/presolve.gms"


* intersolve for food demand model
      sm_intersolve=0;

      while(sm_intersolve = 0,

           sm_intersolve=1;
           display "magpiemini";
           solve magpiemini USING nlp MINIMIZING v15_objective_standalone;
$include "./modules/15_food/elastic_oct16/intersolve.gms"

      );


********************************************************************************
$include "./modules/15_food/elastic_oct16/postsolve.gms"


*************************OPTIMIZATION PROCESS END*******************************
********************************************************************************

**********************WRITE ALL DATA IN 1 GDX FILE******************************
      Execute_Unload "fulldata_demand.gdx";

* clear ct set
      ct(t) = no;
);
********************************************************************************
****************************TIMESTEP LOOP END***********************************


****************************POSTPROCESSING END**********************************
********************************************************************************


*** EOF calculations.gms ***

*** EOF magpie.gms ***