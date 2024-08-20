*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
option threads = 1;
$onecho > cplex.opt
$offecho

* non-linear solver
$ifthen "%c80_nlp_solver%" == "conopt4"
  option nlp        = conopt4;
$elseif "%c80_nlp_solver%" == "conopt4+cplex"
  option nlp        = conopt4;
  s80_add_cplex     = 1;
$elseif "%c80_nlp_solver%" == "conopt4+conopt3"
  option nlp        = conopt4;
  s80_add_conopt3   = 1;
$endif

$onecho > conopt4.opt
Lim_Variable = 1.e25
$offecho

$onecho > conopt4.op2
Flg_Prep = FALSE
$offecho

repeat(

  magpie.trylinear = 1;

* repeat linear solve under relaxed conditions if linear model is infeasible
   repeat(

*' @code All nonlinear terms are fixed to best guess values via `nl_fix.gms`
*' files which must be provided for each nonlinear module realization.

$batinclude "./modules/include.gms" nl_fix

*' After all nonlinearities have been fixed the linear model is solved.
*' Via setting `magpie.trylinear = 1` the following solve statement starts a
*' linear optimization if no non-linearities remain in the model (Please note
*' that the solve statement still declares a nonlinear / nlp problem even
*' though we expect it to be linear!).
*' Solve statement is put twice for improved model results, 
*' in particular for matching LHS and RHS of equations.

    solve magpie USING nlp MINIMIZING vm_cost_glo;
    if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );

*' A second optimization makes sure that in case of a flat optimum that solution
*' is chosen for which the difference in land changes compared to the previous
*' timestep is minimized. This is achieved by setting the calculated total costs
*' of the previous optimization as upper bound and minimizing the land
*' differences.

    if ((magpie.modelstat=1 or magpie.modelstat = 7),
      vm_cost_glo.up = vm_cost_glo.l;
      solve magpie USING nlp MINIMIZING vm_landdiff;
      if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_landdiff; );
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
    p80_num_nonopt(t) = magpie.numNOpt;

*' @code After the linear optimization all nonlinear variables are released
*' again.

$batinclude "./modules/include.gms" nl_release

*' In case that no feasible solution for the linear model is found the best
*' guess estimates for the fixations of nonlinear terms are slightly relaxed
*' to increase the likelihood of finding a feasible solution and the linear
*' solve is repeated. Such as the `nl_fix.gms` and `nl_release.gms` rules also
*' `nl_release.gms` must be provided by the corresponding module realizations.

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

*' @code Finally, the linear solution is used as starting point for
*' the nonlinear optimization of the model in its full complexity.

  solve magpie USING nlp MINIMIZING vm_cost_glo;
  if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );

*' @stop

* if s80_add_conopt3 is 1 add additional solve statement for conopt3
    if((s80_add_conopt3 = 1),
      display "Additional solve with CONOPT3!";
      option nlp = conopt3;
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );
      option nlp = conopt4;
    );

* if solve stopped with an error, try it again with CONOPT4 and OPTFILE
    if((magpie.modelstat = 13),
      display "WARNING: Modelstat 13 | retry without Conopt4 pre-processing";
      option nlp = conopt4;
      magpie.optfile = 2
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );
      magpie.optfile   = s80_optfile ;
    );

* if solve stopped with an error, try it again with conopt3
    if ((magpie.modelstat = 13),
      display "WARNING: Modelstat 13 | retry with CONOPT3!";
      option nlp = conopt3;
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );
      option nlp = conopt4;
    );

  p80_modelstat(t) = magpie.modelstat;
  p80_num_nonopt(t) = magpie.numNOpt;

  display "s80_obj_linear";
  display s80_obj_linear;
  display "vm_cost_glo.l";
  display vm_cost_glo.l;


* write extended run information in list file in the case that the final solution is infeasible
  if ((s80_counter >= s80_maxiter and p80_modelstat(t) > 2),
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
if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );

$batinclude "./modules/include.gms" nl_release

if((magpie.modelstat=1 or magpie.modelstat = 7),
  vm_cost_glo.up = vm_cost_glo.l;
  solve magpie USING nlp MINIMIZING vm_landdiff;
  if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_landdiff; );
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
