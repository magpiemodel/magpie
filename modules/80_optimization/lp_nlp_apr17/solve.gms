*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************
s80_counter = 0;
p80_modelstat(t) = 1;

repeat(
  magpie.trylinear = 1;

* repeat linear solve under relaxed conditions if linear model is infeasible
   repeat(

$batinclude "./modules/include.gms" nl_fix

* ### l_solve ###

    solve magpie USING nlp MINIMIZING vm_cost_glo;

* ### Second optimization which makes sure that the optimum is chosen    ###
* ### for which the difference in land changes compared to the previous  ###
* ### timestep is minimized.                                             ###
* ### for better overall performance only executed if model was feasible ###
    if((magpie.modelstat=1 or magpie.modelstat = 7),
      vm_cost_glo.up = vm_cost_glo.l;
      solve magpie USING nlp MINIMIZING vm_landdiff;
      vm_cost_glo.up = Inf;
    );

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

$batinclude "./modules/include.gms" nl_release

    if((p80_modelstat(t) <> 1),
$batinclude "./modules/include.gms" nl_relax
    );

    display p80_modelstat;
    s80_counter = s80_counter + 1 ;
    until(p80_modelstat(t) = 1 or s80_counter >= s80_maxiter)
  );

  magpie.trylinear = 0;

* ### nl_solve ###

  solve magpie USING nlp MINIMIZING vm_cost_glo;

  p80_modelstat(t) = magpie.modelstat;

  display "s80_obj_linear";
  display s80_obj_linear;
  display "vm_cost_glo.l";
  display vm_cost_glo.l;


* write extended run information in list file in the case that the final solution is infeasible
  if((s80_counter >= s80_maxiter and p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
    magpie.solprint = 1
  );

  display s80_counter;

  until (p80_modelstat(t) <= 2 or s80_counter >= s80_maxiter)
);

if ((p80_modelstat(t) < 3),
  put_utility 'shell' / 'mv magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

***************end solve loop***************
