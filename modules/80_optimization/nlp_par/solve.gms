*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

p80_counter(h) = 0;
p80_modelstat(t,h) = 14;
p80_counter_modelstat(h) = 0;
p80_resolve_option(h) = 0;

*** solver settings
option nlp = conopt4;
option threads = 1;
magpie.solvelink = 3;
magpie.optfile   = s80_optfile ;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;
magpie.savepoint = 0;

$onecho > conopt4.opt
Lim_Variable = 1.e25
$offecho

$onecho > conopt4.op2
Flg_Prep = FALSE
$offecho

$onecho > conopt4.op3
Flg_NoDefc = TRUE
$offecho

h2(h) = no;
i2(i) = no;
j2(j) = no;

*submission loop
loop(h,
  h2(h) = yes;
  i2(i)$supreg(h,i) = yes;
  loop(i2, j2(j)$cell(i2,j) = yes);
  solve magpie USING nlp MINIMIZING vm_cost_glo;
  h2(h) = no;
  i2(i) = no;
  j2(j) = no;
  p80_handle(h) = magpie.handle;
);

*collection loop
repeat
  loop(h$p80_handle(h),
    if(handleStatus(p80_handle(h)) = 2,
      p80_counter(h) = p80_counter(h) + 1;
      p80_extra_solve(h) = 1;

      magpie.handle = p80_handle(h);
      execute_loadhandle magpie;

      h2(h) = yes;
      i2(i)$supreg(h,i) = yes;
      loop(i2, j2(j)$cell(i2,j) = yes);
      display h2;
      s80_counter = sum(h2,p80_counter(h2));
      display s80_counter;
      display magpie.modelStat;
      display vm_cost_glo.l;
      magpie.modelStat$(magpie.modelStat=NA) = 13;
      
      p80_modelstat(t,h) = magpie.modelStat;

      if(p80_counter(h) >= s80_maxiter AND p80_modelstat(t,h) > 2,
          execute 'gmszip -r magpie_problem.zip "%gams.scrdir%"'
          put_utility 'shell' / 'mv -f magpie_problem.zip magpie_problem_' h.tl:0'_' t.tl:0'.zip';
          display "No feasible solution found. Writing LST file.";
          option AsyncSolLst=1;
          display$handlecollect(p80_handle(h)) 're-collect';
          option AsyncSolLst=0;
          p80_extra_solve(h) = 0;
         );

      display$handledelete(p80_handle(h)) 'trouble deleting handles' ;

      if(p80_modelstat(t,h) <= 2,
        p80_counter_modelstat(h) = p80_counter_modelstat(h) + 1;
        if(p80_counter_modelstat(h) < 2 AND s80_secondsolve = 1,
          display "Model status <= 2. Starting second solve";
          solve magpie USING nlp MINIMIZING vm_cost_glo;
          p80_handle(h) = magpie.handle;
          p80_extra_solve(h) = 0;
        else
          display "Model status <= 2. Handle cleared.";
          p80_extra_solve(h) = 0;
          p80_handle(h) = 0;
         );
       );

      if(p80_extra_solve(h) = 1,
        display "Resolve";
        p80_resolve_option(h) = p80_resolve_option(h) + 1;
        s80_resolve_option = sum(h2,p80_resolve_option(h2));
        display s80_resolve_option;
        if(p80_resolve_option(h) = 1,
          display "Modelstat > 2 | Retry solve with CONOPT4 default setting";
          option nlp = conopt4;
          magpie.optfile = 0;         
        elseif p80_resolve_option(h) = 2, 
          display "Modelstat > 2 | Retry solve with CONOPT4 OPTFILE";
          option nlp = conopt4;
          magpie.optfile = 1;         
        elseif p80_resolve_option(h) = 3, 
          display "Modelstat > 2 | Retry solve with CONOPT4 w/o preprocessing";
          option nlp = conopt4;
          magpie.optfile = 2;         
        elseif p80_resolve_option(h) = 4, 
          display "Modelstat > 2 | Retry solve with CONOPT4 w/o search for definitional constraints";
          option nlp = conopt4;
          magpie.optfile = 3;         
        elseif p80_resolve_option(h) = 5, 
          display "Modelstat > 2 | Retry solve with CONOPT3";
          option nlp = conopt3;
          magpie.optfile = 0;         
         );
        if(execerror > 0, execerror = 0);

        solve magpie USING nlp MINIMIZING vm_cost_glo;
        magpie.handle$(magpie.handle = 0) = 1;
        p80_handle(h) = magpie.handle;
        option nlp = conopt4;
        magpie.optfile = s80_optfile; 
        
        p80_resolve_option(h)$(p80_resolve_option(h) >= 5) = 0;
       );
    h2(h) = no;
    i2(i) = no;
    j2(j) = no;
   );
 );
display$sleep(card(p80_handle)*0.2) 'sleep some time';
display$readyCollect(p80_handle,INF) 'Problem waiting for next instance to complete';
until card(p80_handle) = 0 OR smax(h, p80_counter(h)) >= s80_maxiter;

if (smax(h,p80_modelstat(t,h)) > 2 and smax(h,p80_modelstat(t,h)) ne 7,
    Execute_Unload "fulldata.gdx";
    abort "No feasible solution found!";
);

* handleSubmit does not work because it requires the script `gmsrerun.cmd` or `gmsrerun.run` in the grid directory.
* Therefore, solve statements are used.
* display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;

***************end solve loop***************
