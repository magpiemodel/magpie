*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

s80_counter = 0;
p80_modelstat(t) = 14;
s80_resolve_option = 0;

*** solver settings
option nlp = ipopt;
option threads = 1;
magpie.optfile   = s80_optfile;
magpie.scaleopt  = 1 ;
magpie.solprint  = 1 ;
magpie.holdfixed = 1 ;

put optfile;
put 'tol ', s80_toloptimal:12:11 /;
put 'mu_strategy monotone' /;
put 'mu_init 1e-5' /;
* put 'mu_target 1e-5' /;
put 'print_level 5' /;
put 'mu_linear_decrease_factor 0.85' /;
put 'mu_superlinear_decrease_power 1.02' /;
put 'nlp_scaling_method none' /;
* put 'barrier_tol_factor 100' /;
put 'bound_relax_factor 1e-7' /;
put 'honor_original_bounds yes' /;
put 'constr_viol_tol 1e-6' /;
put 'print_timing_statistics yes' /;
put 'dependency_detector mumps' /;
* put 'dependency_detection_with_rhs yes' /;
putclose optfile;

$onecho > ipopt.op2
Lim_Variable = 1.e25
$offecho

if(execerror > 0, 
  abort "Execution error. Check your .lst file.";
);

*' @code
solve magpie USING nlp MINIMIZING vm_cost_glo;
*' Optional second solve statement
if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );
*' @stop

display "vm_cost_glo.l";
display vm_cost_glo.l;
display magpie.modelstat;

* set modelstat to 13 in case of NA for continuation
magpie.modelStat$(magpie.modelStat=NA) = 13;

* in case of problems try different solvers and optfile settings
if (magpie.modelstat > 2,
  repeat(
    s80_counter = s80_counter + 1 ;
    s80_resolve_option = s80_resolve_option + 1;

    solve magpie USING nlp MINIMIZING vm_cost_glo;
    if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );
    option nlp = ipopt;
    magpie.optfile = s80_optfile;

    display "vm_cost_glo.l";
    display vm_cost_glo.l;

*   write extended run information in list file in the case that the final solution is infeasible
    if ((s80_counter >= (s80_maxiter-1) and magpie.modelstat > 2),
      magpie.solprint = 1
    );

    display s80_counter;
    display magpie.modelstat;
*   Set modelstat to 13 in case of NA for the `until` check of the repeat loop.
*   Otherwise, the repeat loop will never end.
    magpie.modelStat$(magpie.modelStat=NA) = 13;

    s80_resolve_option$(s80_resolve_option >= 4) = 0;

    until (magpie.modelstat <= 2 or s80_counter >= s80_maxiter)
  );
);

p80_modelstat(t) = magpie.modelstat;
p80_num_nonopt(t) = magpie.numNOpt;

if ((p80_modelstat(t) <= 2),
  put_utility 'shell' / 'mv -f magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
  execute 'gmszip -r magpie_problem.zip "%gams.scrdir%"'
  put_utility 'shell' / 'mv -f magpie_problem.zip magpie_problem_' t.tl:0'.zip';
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

***************end solve loop***************
