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
p80_resolve_option(h) = 1;

*** solver settings
option nlp = conopt4;
magpie.solvelink = 3;
magpie.optfile   = s80_optfile ;
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
      s80_objective = sum(i2,v11_cost_reg.l(i2));
      display s80_counter;
      display magpie.modelStat;
      display s80_objective;
      magpie.modelStat$(magpie.modelStat=NA) = 13;
      
      s80_modelstat_previter = p80_modelstat(t,h);
      p80_modelstat(t,h) = magpie.modelStat;
      s80_optfile_previter = magpie.optfile;

      if(p80_counter(h) >= s80_maxiter AND p80_modelstat(t,h) > 2,
          if(p80_modelstat(t,h) = 13, 
          execute 'gmszip -r magpie_problem.zip "%gams.scrdir%"'
          put_utility 'shell' / 'mv -f magpie_problem.zip magpie_problem_' h.tl:0'_' t.tl:0'.zip';
           );
          display "No feasible solution found. Writing LST file.";
          option AsyncSolLst=1;
          display$handlecollect(p80_handle(h)) 're-collect';
          option AsyncSolLst=0;
          p80_extra_solve(h) = 0;
         );

      display$handledelete(p80_handle(h)) 'trouble deleting handles' ;

      if(p80_modelstat(t,h) <= 2,
        p80_counter_modelstat(h) = p80_counter_modelstat(h) + 1;
        if(p80_counter_modelstat(h) < 2,
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
        display "Resolve"
        if(p80_resolve_option(h) = 1,
          display "Modelstat > 2 | Retry solve with CONOPT4 default setting";
          magpie.optfile = 0;         
        elseif p80_resolve_option(h) = 2, 
          display "Modelstat > 2 | Retry solve with CONOPT4 default setting and magpie_p_last_timestep.gdx";
          magpie.optfile = 0;         
          Execute_Loadpoint "magpie_p_last_timestep.gdx";
        elseif p80_resolve_option(h) = 3, 
          display "Modelstat > 2 | Retry solve with CONOPT4 default setting and magpie_y2020.gdx";
          magpie.optfile = 0;          
          Execute_Loadpoint "magpie_y2020.gdx";
        elseif p80_resolve_option(h) = 4,
          display "Modelstat > 2 | Retry solve with CONOPT4 OPTFILE";
          magpie.optfile = 1;          
        elseif p80_resolve_option(h) = 5,
          display "Modelstat > 2 | Retry solve with CONOPT4 OPTFILE and magpie_p_last_timestep.gdx";
          magpie.optfile = 1;          
          Execute_Loadpoint "magpie_p_last_timestep.gdx";
        elseif p80_resolve_option(h) = 6,
          display "Modelstat > 2 | Retry solve with CONOPT4 OPTFILE and magpie_y2020.gdx";
          magpie.optfile = 1;          
          Execute_Loadpoint "magpie_y2020.gdx";
         );
        if(execerror > 0, execerror = 0);
        s80_objective = sum(i2,v11_cost_reg.l(i2));
        display s80_objective;
        solve magpie USING nlp MINIMIZING vm_cost_glo;
        if (p80_resolve_option(h) < 6,
          p80_resolve_option(h) = p80_resolve_option(h) + 1;
        else 
          p80_resolve_option(h) = 1;
         );
        if(magpie.handle = 0,
          display "Problem. Handle is zero despite resolve. Setting handle to 1 for continuation.";
          magpie.handle = 1;
         );
        p80_handle(h) = magpie.handle;
       );
    h2(h) = no;
    i2(i) = no;
    j2(j) = no;
   );
 );
display$sleep(card(p80_handle)*0.2) 'sleep some time';
display$readyCollect(p80_handle,INF) 'Problem waiting for next instance to complete';
until card(p80_handle) = 0 OR smax(h, p80_counter(h)) >= s80_maxiter;

* Save results to gdx point files
* Historical period for magpie_p_y[XXXX].gdx files is excluded to avoid diversion of results compared to other model runs if restarted with s_use_gdx = 2.
if (smax(h,p80_modelstat(t,h)) <= 2,
  put_utility 'shell' / 'cp -f magpie_p.gdx magpie_p_last_timestep.gdx';
  if (m_year(t) > sm_fix_SSP2,
    put_utility 'shell' / 'cp -f magpie_p.gdx magpie_' t.tl:0'.gdx';
  );
  put_utility 'shell' / 'rm -f magpie_p.gdx';
);

if (smax(h,p80_modelstat(t,h)) > 2 and smax(h,p80_modelstat(t,h)) ne 7,
    Execute_Unload "fulldata.gdx";
    abort "No feasible solution found!";
);

* handleSubmit does not work because it requires the script `gmsrerun.cmd` or `gmsrerun.run` in the grid directory.
* Therefore, solve statements are used.
* display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;

***************end solve loop***************
