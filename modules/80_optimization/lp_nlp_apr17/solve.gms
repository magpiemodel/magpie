*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

s80_counter = 0;
p80_modelstat(t) = 1;

*** solver settings 

magpie.optfile   = s80_optfile ;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

* linear solver
option lp         = cplex ;
option qcp        = cplex ;
$onecho > cplex.opt
$offecho

* non-linear solver
$ifthen "%c80_nlp_solver%" == "conopt3"
  option nlp        = conopt ;
$elseif "%c80_nlp_solver%" == "conopt4"
  option nlp        = conopt4;
$elseif "%c80_nlp_solver%" == "conopt4+cplex"
  option nlp        = conopt4;
  s80_add_cplex     = 1;
$elseif "%c80_nlp_solver%" == "conopt4+conopt3"
  option nlp        = conopt4; 
  s80_add_conopt3   = 1;
$endif

$onecho > conopt4.opt
Lin_Method = 1
Tol_Obj_Change = 1.0e-5
Lim_Iteration = 1000
$offecho


repeat(

  magpie.trylinear = 1;

* repeat linear solve under relaxed conditions if linear model is infeasible
   repeat(

*' @code All nonlinear terms are fixed to buest guess values through `nl_fix.gms`
*' which need to be provided by each module realization which contains nonlinear
*' terms.

$batinclude "./modules/include.gms" nl_fix

*' After fixing the linear model is solved. Via setting `magpie.trylinear = 1`
*' the following statement starts a linear solve if no non-linearities
*' remain in the model.

    solve magpie USING nlp MINIMIZING vm_cost_glo;

*' A second optimization makes sure that the optimum is chosen for which
*' the difference in land changes compared to the previous timestep is
*' minimized. This is achieved by setting the calculated total costs of the
*' previous optimization as upper bound and minimizing the land differences.

    if((magpie.modelstat=1 or magpie.modelstat = 7),
      vm_cost_glo.up = vm_cost_glo.l;
      solve magpie USING nlp MINIMIZING vm_landdiff;
      vm_cost_glo.up = Inf;
    );

*' @stop

* Check the linear solve.
    if ((magpie.modelstat = 1 or magpie.modelstat = 7),
* Optimal or feasible solution
      s80_obj_linear = vm_cost_glo.l;
    elseif (magpie.modelstat = 2),
      display "It seems that not all nonlinear terms have been fixed for the";
      display "linear solve. Please check that all realizations with nonlinear";
      display "terms provide a nl_fix.gms and a nl_release.gms which fix and";
      display "release the corresponding nonlinear terms for the linear solve!";
      abort "Unfixed nonlinear terms in linear solve!"
    else
* Something is wrong with the solution
      s80_obj_linear =  Inf;
    );

    p80_modelstat(t) = magpie.modelstat;

*' @code After the linear solve all nonlinear variables are released again.

$batinclude "./modules/include.gms" nl_release

*' In case that no feasible solution for the linear model is found the best
*' guess estimates for the fixations of nonlinear terms are slightly relaxed
*' to increase the likelihood of finding a feasible solution and the linear
*' solve is repeated. Such as fixation and release rules also the relaxation
*' rules must be provided by the corresponding module realizations.

    if((p80_modelstat(t) <> 1),
$batinclude "./modules/include.gms" nl_relax
    );

*' @stop

    display p80_modelstat;
    s80_counter = s80_counter + 1 ;
    until(p80_modelstat(t) = 1 or s80_counter >= s80_maxiter)
  );

  magpie.trylinear = 0;

* ### nl_solve ###

*' @code Finally, the optimized, linear solution is used as starting point for
*' the nonlinear solve and the model is solved in its full complexity.

  solve magpie USING nlp MINIMIZING vm_cost_glo;

*' @stop

* if s80_add_conopt3 is 1 add additional solve statement for conopt3
    if((s80_add_conopt3 = 1),
      display "Additional solve with CONOPT3!";
      option nlp = conopt;
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      option nlp = conopt4;
    );

* if solve stopped with an error, try it again with conopt3
  if((magpie.modelstat = 13),
    display "WARNING: Modelstat 13 | retry with CONOPT3!";
    option nlp = conopt;
    solve magpie USING nlp MINIMIZING vm_cost_glo;
    option nlp = conopt4;
  );

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

* if s80_add_cplex is 1 add additional solve statement for cplex
if((s80_add_cplex = 1),
     
magpie.trylinear = 1;

$batinclude "./modules/include.gms" nl_fix

solve magpie USING nlp MINIMIZING vm_cost_glo;

$batinclude "./modules/include.gms" nl_release

if((magpie.modelstat=1 or magpie.modelstat = 7),
  vm_cost_glo.up = vm_cost_glo.l;
  solve magpie USING nlp MINIMIZING vm_landdiff;
  vm_cost_glo.up = Inf;
);
	  
magpie.trylinear = 0;
);

if ((p80_modelstat(t) < 3),
  put_utility 'shell' / 'mv -f magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);


***************end solve loop***************
