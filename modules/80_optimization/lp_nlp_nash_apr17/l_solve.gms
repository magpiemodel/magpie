*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

magpie.solvelink = 3;

* ### l_solve ###

i2(i) = no;
j2(j) = no;

Repeat
  loop(i,
  	i2(i) = yes;
  	j2(j) = yes$cell(i,j);
    if((p80_initialized(i)=0),
  	 solve magpie USING nlp MINIMIZING vm_cost_glo;
     p80_handle(i) = magpie.handle;
     p80_initialized(i) = 1;
    )

    if(handlecollect(p80_handle(i))=1,
      p80_modelstat(t,i) = magpie.modelstat;
      * ### Second optimization which makes sure that the optimum is chosen    ###
      * ### for which the difference in land changes compared to the previous  ###
      * ### timestep is minimized.                                             ###
      * ### for better overall performance only executed if model was feasible ###
      if((magpie.modelstat=1 or magpie.modelstat = 7),
        vm_cost_glo.up = vm_cost_glo.l;
        solve magpie USING nlp MINIMIZING vm_landdiff;
        vm_cost_glo.up = Inf;
        p80_handle2(i) = magpie.handle;
      );
  	  display$handledelete(p80_handle(i)) 'trouble deleting handles' ;
  	  p80_handle(i) = 0  
    )

  	i2(i) = no;
  	j2(j) = no;
  );

  loop(i$,
   i2(i) = yes;
    j2(j) = yes$cell(i,j);
	  i2(i) = no;
    j2(j) = no;
   ) ;
   loop(i$handlecollect(p80_handle2(i)),
      i2(i) = yes;
      j2(j) = yes$cell(i,j);
     p80_modelstat(t,i) = magpie.modelstat;
     display$handledelete(p80_handle2(i)) 'trouble deleting handles' ;
     p80_handle2(i) = 0
     i2(i) = no;
     j2(j) = no;

   );
display$sleep(5) 'sleep some time';
until card(p80_handle) = 0 and card(p80_handle2) = 0;


* Check the linear solve.
if ((magpie.modelstat = 1 or magpie.modelstat = 7),
* Optimal or feasible solution
  s80_obj_linear = vm_cost_glo.l;
elseif (magpie.modelstat = 2),
  abort "It seems that not all nonlinear terms have been fixed for the linear solve. Please check that all realizations with nonlinear terms provide a nl_fix.gms and a nl_release.gms which fix and release the corresponding nonlinear terms for the linear solve!";
else
* Something is wrong with the solution
  s80_obj_linear =  Inf;
);

p80_modelstat(t) = magpie.modelstat;
pm_modelstat = magpie.modelstat;
