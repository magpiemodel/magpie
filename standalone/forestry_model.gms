*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* This is a standalone skeleton which should be used as template
* if only parts of the model should be run. It contains the basic,
* structural components of the model.
* To use it, please copy this file, give it an explaining name and
* save it in the "models" folder. After that you can modify it based
* on the given requirements. You can add own code, but also delete
* code (e.g. the model statement or the provided loops) if these parts
* are irrelevant for your analysis.

$title Forestry_Standalone_Model

$offupper
$offsymxref
$offsymlist
$offlisting

$setglobal c_timesteps  1

*******************************MODULE SETUP*************************************
$setglobal drivers  aug17
$setglobal land  landmatrix_dec18
$setglobal interest_rate  reg_feb18
$setglobal forestry  dynamic_dec18
$setglobal natveg  dynamic_dec18
$setglobal climate static
$setglobal carbon normal_dec17
$setglobal ghg_policy  price_jan19
*$setglobal maccs  on_sep16
*$setglobal landconversion  global_static_aug18

***************************PREDEFINED MACROS************************************
$include "./core/macros.gms"

***************************BASIC SETS INDICES***********************************
$include "./core/sets.gms"
$batinclude "./modules/include.gms" sets

** Additional sets needed
sets
 k(kall) Primary products
  / tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower,
   oilpalm, puls_pro, potato, cassav_sp, sugr_cane, sugr_beet, others,
   foddr, pasture, cottn_pro, begr, betr, livst_rum, livst_pig,
   livst_chick, livst_egg, livst_milk, fish, wood, woodfuel /

 kforestry(k) forestry products
        / wood, woodfuel /
;

**********INTRODUCE CALCULATION PARAMETERS, VARIABLES AND EQUATIONS*************
$include "./core/declarations.gms"
$batinclude "./modules/include.gms" declarations

*parameters
* p_example(exampleset)  example parameter (1)
*;

*variables
* v_example example variable (1)
*;

*equations
* q_example example equation (1)
*;

*****************************IMPORT DATA FILES**********************************
$batinclude "./modules/include.gms" input

********************OBJECTIVE FUNCTION & CONSTRAINTS****************************
$batinclude "./modules/include.gms" equations

*q_example ..
*      v_example =g= sum(exampleset, p_example(exampleset));


*******************MODEL DEFINITION & SOLVER OPTIONS****************************
model forestry_standalone / all /;
forestry_standalone.scaleopt  = 1 ;
forestry_standalone.holdfixed = 1 ;

option lp         = cplex ;
option nlp        = conopt4 ;
option iterlim    = 1000000 ;
option reslim     = 1000000 ;
option sysout     = Off ;
option savepoint  = 1 ;

*model example / q_example /;

*****************************VARIABLE SCALING***********************************
$batinclude "./modules/include.gms" scaling

****************************PREPROCESSING START*********************************
* In this section everything is calculated that is not influenced by the
* optimization process. Hence these lines CAN INFLUENCE the optimization process
* but CANNOT BE INFLUENCED by it.

$batinclude "./modules/include.gms" preloop

*p_example(exampleset) = 1;

* create dummy file (this is necessary to be able to use put_utility and it has
* to be done here because a file declaration cannot be inside a loop
file dummy; dummy.pw=2000; put dummy;

************************OPTIMIZATION PROCESS START******************************
* This section contains only sourcecode that is directly connected to the
* optimization process. That means that everything on the following lines
* INFLUENCES and IS INFLUENCED by the optimization process (except the
* redefinition on preprocessed data).
* Hence one can describe this section together with the constraints section
* as "model-core".

* clear ct set
ct(t) = no;

***************************TIMESTEP LOOP START**********************************
loop (t,

* set ct to current time period
  ct(t) = yes;
  display "Year";
  display ct;

$batinclude "./modules/include.gms" presolve

* intersolve for food demand model
  sm_intersolve=0;

  while(sm_intersolve = 0,

*************************SOLVE STATEMENT START**********************************
* #### additional phases ###
* set additional phases which should be detected by
* update_module_embeddings. Most phases will be detected automatically,
* but batincludes used within a module are not detected and therefore
* have to be set manually! (Syntax: "* !add_phase!: <phase>")
* !add_phase!: nl_fix
* !add_phase!: nl_release
* !add_phase!: nl_relax

$batinclude "./modules/include.gms" solve

* intersolve for food demand model
  sm_intersolve=1;
*  solve example USING lp MINIMIZING v_example;


$batinclude "./modules/include.gms" intersolve

  );

**************************SOLVE STATEMENT END***********************************

$batinclude "./modules/include.gms" postsolve

**********************WRITE ALL DATA IN 1 GDX FILE******************************
  Execute_Unload "fulldata.gdx";

* clear ct set
  ct(t) = no;
);
****************************TIMESTEP LOOP END***********************************
