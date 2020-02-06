*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

$ifthen "%c80_nlp_solver%" == "conopt3"
  option nlp        = conopt ;
$elseif "%c80_nlp_solver%" == "conopt4"
  option nlp        = conopt4;
$else
  abort "c80_nlp_solver setting not supported in nlp_apr17 realization!";
$endif

s80_counter = 0;
s80_forestry_counter = 0;
p80_modelstat(t) = 1;

*** solver settings

magpie.optfile   = s80_optfile ;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

$onecho > conopt4.opt
Tol_Obj_Change = 3.0e-6
Tol_Feas_Min = 1.0e-6
Tol_Feas_Max = 1.0e-5
$offecho

$onecho > conopt.opt
RTMAXV = 1.0e25
$offecho

repeat(
   s80_counter = s80_counter + 1 ;
   s80_forestry_counter = s80_forestry_counter + 1 ;

*' @code
  solve magpie USING nlp MINIMIZING vm_cost_glo;
*' @stop

* if solve stopped with an error, try it again with conopt3
    if((magpie.modelstat = 13),
      display "WARNING: Modelstat 13 | retry with CONOPT3!";
      option nlp = conopt;
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      magpie.solprint  = 1 ;
      option nlp = conopt4;
      magpie.solprint  = 0 ;
    );

    if((magpie.modelstat = 1 OR magpie.modelstat = 2 OR magpie.modelstat = 7),
      magpie.solprint = 0;
    );

    if((magpie.modelstat ne 1 and magpie.modelstat ne 2 and magpie.modelstat ne 7),
      display "WARNING: Modelstat is neither 1,2,7. SOLPRINT SET TO 1.";
      magpie.solprint = 1;
    );

    if((magpie.modelstat = 4 and s80_forestry_counter <= 1),
      display "WARNING: Modelstat 4, SOLPRINT SET TO 1.";
      magpie.solprint  = 1 ;
    );

    if((magpie.modelstat = 4 and s80_forestry_counter > 1),
      abort "Forestry run failed. Check lst file for more details!";
    );

  p80_modelstat(t) = magpie.modelstat;
  p80_num_nonopt(t) = magpie.numNOpt;

  display "vm_cost_glo.l";
  display vm_cost_glo.l;

* write extended run information in list file in the case that the final solution is infeasible
  if((s80_counter >= (s80_maxiter-1) and p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
    magpie.solprint = 1
  );

  display s80_counter;

  until ((p80_modelstat(t) <= 2 and p80_num_nonopt(t) <= s80_num_nonopt_allowed) or s80_counter >= s80_maxiter)
);

*' @stop

if ((p80_modelstat(t) < 3),
  put_utility 'shell' / 'mv -f magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

***************end solve loop***************
