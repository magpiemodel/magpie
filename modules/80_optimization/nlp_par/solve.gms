*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
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

p80_counter(i) = 0;
p80_modelstat(t,i) = 1;

*** solver settings

magpie.optfile   = s80_optfile ;
magpie.scaleopt  = 1 ;
magpie.solprint  = 0 ;
magpie.holdfixed = 1 ;

$onecho > conopt4.opt
Tol_Obj_Change = 3.0e-6
Tol_Feas_Min = 4.0e-7
Tol_Feas_Max = 4.0e-6
Tol_Feas_Tria = 4.0e-6
$offecho

$onecho > conopt4.op2
Flg_Prep = FALSE
$offecho

magpie.solvelink = 6;
h2(h) = no;
i2(i) = no;
j2(j) = no;

*submission loop
loop(h,
  h2(h) = yes;
	i2(i) = yes$supreg(h,i);
	j2(j) = yes$cell(i2,j);
	solve magpie USING nlp MINIMIZING vm_cost_glo ;
*	display j2;
*	display i2;
  h2(h) = no;
	i2(i) = no;
	j2(j) = no;
	p80_handle(h) = magpie.handle;
);

*collection loop
repeat
  loop(h$p80_handle(h),
    if(handleStatus(p80_handle(h)) = 2,
      magpie.handle = p80_handle(h);
      execute_loadhandle magpie;
		  magpie.modelstat$(magpie.modelstat=NA) = 13;
		  p80_modelstat(t,h) = magpie.modelstat;
      h2(h) = yes;
      i2(i) = yes$supreg(h,i);
      j2(j) = yes$cell(i2,j);
      display h2;
      display magpie.modelstat;
		  display$handledelete(p80_handle(h)) 'trouble deleting handles' ;
      if (magpie.modelstat <= 2,
		    p80_handle(h) = 0;
		  else
		    if(magpie.modelstat = 13,
          display "WARNING: Modelstat 13 | retry without Conopt4 pre-processing";
		      magpie.optfile = 2
	        solve magpie USING nlp MINIMIZING vm_cost_glo;
	        magpie.optfile = s80_optfile ;
		      p80_handle(h)  = magpie.handle;
		      p80_counter(h) = p80_counter(h) + 1;
		    else
		      solve magpie USING nlp MINIMIZING vm_cost_glo ;
		      p80_handle(h)  = magpie.handle;
		      p80_counter(h) = p80_counter(h) + 1;
		    );
      );
		  execerror = 0;
      h2(h) = no;
		  i2(i) = no;
		  j2(j) = no;
* write extended run information in list file in the case that the final solution is infeasible
  	  if((p80_counter(h) >= (s80_maxiter-1) and p80_modelstat(t,h) > 2 and p80_modelstat(t,h) ne 7),
    		magpie.solprint = 1
  	  );
    );
  );
  display$readyCollect(p80_handle) 'Problem waiting for next instance to complete';
  until card(p80_handle) = 0 OR smax(i, p80_counter(h)) >= s80_maxiter;
  execerror = 0;

  if (smax(i,p80_modelstat(t,h)) > 2 and smax(i,p80_modelstat(t,h)) ne 7,
    Execute_Unload "fulldata.gdx";
    abort "no feasible solution found!";
  );

* handleSubmit does not work as expected. Does not restart from saved state.
* Therefore, solve statements are used.
* display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;

***************end solve loop***************
