*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

s80_counter = 0;
p80_modelstat(t) = 14;

*** solver settings
option nlp = ipopt;
option threads = 1;

* Default optfile, starting immediately with the monotone mu_strategy to make
* the behavior more consistent.
put optfile;
put 'tol ', s80_toloptimal:12:11 /;
put 'mu_strategy monotone' /;
put 'mu_init 1e-5' /;
put 'mu_linear_decrease_factor 0.85' /;
put 'mu_superlinear_decrease_power 1.02' /;
put 'nlp_scaling_method none' /;
put 'bound_relax_factor 1e-7' /;
put 'honor_original_bounds yes' /;
put 'constr_viol_tol 1e-6' /;
put 'dependency_detector mumps' /;
putclose optfile;

* Alternative optfile, making use of the adaptive mu_strategy which starts faster
* but is less reliable. Seems to behave better for values near zero.
put optfile2;
put 'tol ', s80_toloptimal:12:11 /;
put 'constr_viol_tol 1e-6' /;
put 'mu_strategy adaptive' /;
put 'mu_oracle quality-function' /;
put 'quality_function_max_section_steps 4' /;
put 'nlp_scaling_method gradient-based' /;
put 'nlp_scaling_max_gradient 100' /;
put 'acceptable_iter 10' /;
put 'acceptable_constr_viol_tol 1e-3' /;
put 'acceptable_dual_inf_tol 1e-2' /;
put 'acceptable_compl_inf_tol 1e-2' /;
put 'bound_relax_factor 1e-7' /;
put 'honor_original_bounds yes' /;
put 'max_iter 10000' /;
put 'linear_solver mumps' /;
put 'dependency_detector mumps' /;
putclose optfile2;

magpie.optfile   = s80_optfile;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

if(execerror > 0, 
  abort "Execution error. Check your .lst file.";
);

*' @code
solve magpie USING nlp MINIMIZING vm_cost_glo;
*' @stop

display "vm_cost_glo.l";
display vm_cost_glo.l;
display magpie.modelstat;

* set modelstat to 13 in case of NA for continuation
magpie.modelStat$(magpie.modelStat=NA) = 13;

* in case of problems restart the solver with the same optfile settings
if (magpie.modelstat > 2,
  repeat(
    s80_counter = s80_counter + 1 ;

    solve magpie USING nlp MINIMIZING vm_cost_glo;

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
