*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

* ### nl_solve ###

solve magpie USING nlp MINIMIZING vm_cost_glo;

* Check the nonlinear solve.
  if ((magpie.modelstat <= 2 or magpie.modelstat = 7),
* Optimal or feasible solution
    sm_obj_diff = abs(vm_cost_glo.l - s80_obj_linear);
  else
* Something is wrong with the solution
    sm_obj_diff = Inf;
  );

p80_modelstat(t) = magpie.modelstat;
pm_modelstat = magpie.modelstat;

display "s80_obj_linear";
display s80_obj_linear;
display "vm_cost_glo.l";
display vm_cost_glo.l;
display "sm_obj_diff";
display sm_obj_diff;
