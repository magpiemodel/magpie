*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

****************************PREPROCESSING START*********************************
* In this section everything is calculated that is not influenced by the
* optimization process. Hence these lines CAN INFLUENCE the optimization process
* but CANNOT BE INFLUENCED by it.


$batinclude "./modules/include.gms" preloop

*****************************PREPROCESSING END**********************************


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

*************************** GDX LOADPOINTS *************************************
$include "./core/load_gdx.gms"
********************************************************************************

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

$batinclude "./modules/include.gms" intersolve

  );

**************************SOLVE STATEMENT END***********************************

$batinclude "./modules/include.gms" postsolve

*************************OPTIMIZATION PROCESS END*******************************

**********************WRITE ALL DATA IN 1 GDX FILE******************************
  Execute_Unload "fulldata.gdx";

* clear ct set
  ct(t) = no;
********************************************************************************
);
****************************TIMESTEP LOOP END***********************************

*** EOF calculations.gms ***
