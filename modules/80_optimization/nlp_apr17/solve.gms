*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
p80_modelstat(t) = 14;
s80_modelstat_previter = 14;
s80_optfile_previter = s80_optfile;

*** solver settings
magpie.optfile   = s80_optfile;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

$onecho > conopt4.opt
Tol_Obj_Change = 3.0e-6
Tol_Feas_Min = 4.0e-10
Tol_Feas_Max = 4.0e-6
Tol_Feas_Tria = 4.0e-6
$offecho

$onecho > conopt4.op2
Flg_Prep = FALSE
$offecho

*' @code
solve magpie USING nlp MINIMIZING vm_cost_glo;
*' @stop

display "vm_cost_glo.l";
display vm_cost_glo.l;
display magpie.modelstat;

* in case of problems try different solvers and optfile settings
if (magpie.modelstat > 2,
  repeat(
    s80_counter = s80_counter + 1 ;

  if (magpie.modelstat ne s80_modelstat_previter,
    display "Modelstat > 2 | Retry solve with CONOPT4 default setting";
    solve magpie USING nlp MINIMIZING vm_cost_glo ;
  elseif magpie.modelstat = s80_modelstat_previter,
      if(magpie.optfile = s80_optfile_previter,
            display "Modelstat > 2 | Retry solve without CONOPT4 pre-processing";
        magpie.optfile = 2;
          solve magpie USING nlp MINIMIZING vm_cost_glo;
          magpie.optfile   = s80_optfile;
    else
      display "Modelstat > 2 | Retry solve with CONOPT3";
      option nlp = conopt;
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      option nlp = conopt4;
      );
    );

  s80_modelstat_previter = magpie.modelstat;
  s80_optfile_previter = magpie.optfile;

  display "vm_cost_glo.l";
  display vm_cost_glo.l;

* write extended run information in list file in the case that the final solution is infeasible
  if ((s80_counter >= (s80_maxiter-1) and magpie.modelstat > 2),
    magpie.solprint = 1
  );

  display s80_counter;
  display magpie.modelstat;

  until (magpie.modelstat <= 2 or s80_counter >= s80_maxiter)
  );
);

p80_modelstat(t) = magpie.modelstat;
p80_num_nonopt(t) = magpie.numNOpt;

if ((p80_modelstat(t) <= 2),
  put_utility 'shell' / 'mv -f magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

***************end solve loop***************
