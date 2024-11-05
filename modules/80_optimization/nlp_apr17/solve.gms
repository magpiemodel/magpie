*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
option nlp = conopt4;
option threads = 1;
magpie.optfile   = s80_optfile;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

$onecho > conopt4.opt
Lim_Variable = 1.e25
$offecho

$onecho > conopt4.op2
Flg_Prep = FALSE
$offecho

$onecho > conopt4.op3
Flg_NoDefc = TRUE
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

    if(s80_resolve_option = 1,
      display "Modelstat > 2 | Retry solve with CONOPT4 default setting";
      option nlp = conopt4;
      magpie.optfile = 0;
    elseif s80_resolve_option = 2,
      display "Modelstat > 2 | Retry solve with CONOPT4 OPTFILE";
      option nlp = conopt4;
      magpie.optfile = 1;
    elseif s80_resolve_option = 3,
      display "Modelstat > 2 | Retry solve with CONOPT4 w/o preprocessing";
      option nlp = conopt4;
      magpie.optfile = 2;
    elseif s80_resolve_option = 4,
      display "Modelstat > 2 | Retry solve with CONOPT4 w/o search for definitional constraints";
      option nlp = conopt4;
      magpie.optfile = 3;
    elseif s80_resolve_option = 5,
      display "Modelstat > 2 | Retry solve with CONOPT3";
      option nlp = conopt3;
      magpie.optfile = 0;
     );

    solve magpie USING nlp MINIMIZING vm_cost_glo;
    if(s80_secondsolve = 1, solve magpie USING nlp MINIMIZING vm_cost_glo; );
    option nlp = conopt4;
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

    s80_resolve_option$(s80_resolve_option >= 5) = 0;

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
