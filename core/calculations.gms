*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

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

* Loading gdx-files (sm_use_gdx>0)
           if((sm_use_gdx > 0),
$if exist "magpie_y1995.gdx"  if(sameas(t,"y1995"), Execute_Loadpoint "magpie_y1995.gdx"; );
           );

           if((sm_use_gdx = 2),
$if exist "magpie_y2000.gdx"  if(sameas(t,"y2000"), Execute_Loadpoint "magpie_y2000.gdx"; );
$if exist "magpie_y2005.gdx"  if(sameas(t,"y2005"), Execute_Loadpoint "magpie_y2005.gdx"; );
$if exist "magpie_y2010.gdx"  if(sameas(t,"y2010"), Execute_Loadpoint "magpie_y2010.gdx"; );
$if exist "magpie_y2015.gdx"  if(sameas(t,"y2015"), Execute_Loadpoint "magpie_y2015.gdx"; );
$if exist "magpie_y2020.gdx"  if(sameas(t,"y2020"), Execute_Loadpoint "magpie_y2020.gdx"; );
$if exist "magpie_y2025.gdx"  if(sameas(t,"y2025"), Execute_Loadpoint "magpie_y2025.gdx"; );
$if exist "magpie_y2030.gdx"  if(sameas(t,"y2030"), Execute_Loadpoint "magpie_y2030.gdx"; );
$if exist "magpie_y2035.gdx"  if(sameas(t,"y2035"), Execute_Loadpoint "magpie_y2035.gdx"; );
$if exist "magpie_y2040.gdx"  if(sameas(t,"y2040"), Execute_Loadpoint "magpie_y2040.gdx"; );
$if exist "magpie_y2045.gdx"  if(sameas(t,"y2045"), Execute_Loadpoint "magpie_y2045.gdx"; );
$if exist "magpie_y2050.gdx"  if(sameas(t,"y2050"), Execute_Loadpoint "magpie_y2050.gdx"; );
$if exist "magpie_y2055.gdx"  if(sameas(t,"y2055"), Execute_Loadpoint "magpie_y2055.gdx"; );
$if exist "magpie_y2060.gdx"  if(sameas(t,"y2060"), Execute_Loadpoint "magpie_y2060.gdx"; );
$if exist "magpie_y2065.gdx"  if(sameas(t,"y2065"), Execute_Loadpoint "magpie_y2065.gdx"; );
$if exist "magpie_y2070.gdx"  if(sameas(t,"y2070"), Execute_Loadpoint "magpie_y2070.gdx"; );
$if exist "magpie_y2075.gdx"  if(sameas(t,"y2075"), Execute_Loadpoint "magpie_y2075.gdx"; );
$if exist "magpie_y2080.gdx"  if(sameas(t,"y2080"), Execute_Loadpoint "magpie_y2080.gdx"; );
$if exist "magpie_y2085.gdx"  if(sameas(t,"y2085"), Execute_Loadpoint "magpie_y2085.gdx"; );
$if exist "magpie_y2090.gdx"  if(sameas(t,"y2090"), Execute_Loadpoint "magpie_y2090.gdx"; );
$if exist "magpie_y2095.gdx"  if(sameas(t,"y2095"), Execute_Loadpoint "magpie_y2095.gdx"; );
$if exist "magpie_y2100.gdx"  if(sameas(t,"y2100"), Execute_Loadpoint "magpie_y2100.gdx"; );
$if exist "magpie_y2105.gdx"  if(sameas(t,"y2105"), Execute_Loadpoint "magpie_y2105.gdx"; );
$if exist "magpie_y2110.gdx"  if(sameas(t,"y2110"), Execute_Loadpoint "magpie_y2110.gdx"; );
$if exist "magpie_y2115.gdx"  if(sameas(t,"y2115"), Execute_Loadpoint "magpie_y2115.gdx"; );
$if exist "magpie_y2120.gdx"  if(sameas(t,"y2120"), Execute_Loadpoint "magpie_y2120.gdx"; );
$if exist "magpie_y2125.gdx"  if(sameas(t,"y2125"), Execute_Loadpoint "magpie_y2125.gdx"; );
$if exist "magpie_y2130.gdx"  if(sameas(t,"y2130"), Execute_Loadpoint "magpie_y2130.gdx"; );
$if exist "magpie_y2135.gdx"  if(sameas(t,"y2135"), Execute_Loadpoint "magpie_y2135.gdx"; );
$if exist "magpie_y2140.gdx"  if(sameas(t,"y2140"), Execute_Loadpoint "magpie_y2140.gdx"; );
$if exist "magpie_y2145.gdx"  if(sameas(t,"y2145"), Execute_Loadpoint "magpie_y2145.gdx"; );
$if exist "magpie_y2150.gdx"  if(sameas(t,"y2150"), Execute_Loadpoint "magpie_y2150.gdx"; );
          );


*************************SOLVE STATEMENT START**********************************

**************start solve loop**************
           s_counter = 0;
           pm_modelstat = 1;

           repeat(

             magpie.trylinear = 1;

* repeat linear solve under relaxed conditions if linear model is infeasible
             repeat(

$batinclude "./modules/include.gms" nl_fix
$batinclude "./modules/include.gms" l_solve
$batinclude "./modules/include.gms" nl_release

               if((pm_modelstat <> 1),
$batinclude "./modules/include.gms" nl_relax
               );

                   display pm_modelstat;
                   s_counter = s_counter + 1 ;
               until(pm_modelstat = 1 or s_counter >= sm_maxiter)
             );

             magpie.trylinear = 0;

$batinclude "./modules/include.gms" nl_solve


* write extended run information in list file in the case that the final solution is infeasible
             if((s_counter >= sm_maxiter and pm_modelstat > 2 and pm_modelstat ne 7),
               magpie.solprint = 1
             );

             display s_counter;

             until (pm_modelstat <= 2 or s_counter >= sm_maxiter)
           );
***************end solve loop***************


           if ((pm_modelstat < 3),
             put_utility 'shell' / 'mv magpie_p.gdx magpie_' t.tl:0'.gdx';
           );

           if ((pm_modelstat > 2 and pm_modelstat ne 7),
                Execute_Unload "fulldata.gdx";
                abort "no feasible solution found ",pm_modelstat;
           );

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
