*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


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

  vm_landdiff.up = vm_landdiff.l;
  solve magpie USING nlp MINIMIZING vm_cost_glo;
  vm_landdiff.up = Inf;
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

if ((magpie.modelstat <= 2),
* Optimal solution
    sm_obj_diff = 0;
else
* Something is wrong with the solution
    sm_obj_diff = Inf;
);

p80_modelstat(t) = magpie.modelstat;
pm_modelstat = magpie.modelstat;
