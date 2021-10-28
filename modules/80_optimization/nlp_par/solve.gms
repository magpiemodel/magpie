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

p80_counter(h) = 0;
p80_modelstat(t,h) = 1;
p80_resolve(h) = no;

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

magpie.solvelink = 3;
h2(h) = no;
i2(i) = no;
j2(j) = no;

*submission loop
loop(h,
  h2(h) = yes;
	i2(i) = yes$supreg(h,i);
  loop(i2, j2(j) = yes$cell(i2,j));
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
  loop(h$handlecollect(p80_handle(h)),
		  magpie.modelstat$(magpie.modelstat=NA) = 13;
		  h2(h) = yes;
      i2(i) = yes$supreg(h,i);
      loop(i2, j2(j) = yes$cell(i2,j));
      display h2;
      display p80_counter;
      display magpie.modelstat;
      if(magpie.modelStat > 2 and magpie.modelStat ne 7 and p80_resolve(h),
      option AsyncSolLst=1;
      display$handlecollect(p80_handle(h)) 're-collect';
      option AsyncSolLst=0;
      p80_resolve(h) = no;
      p80_counter(h) = p80_counter(h) + 1;
      );
      display$handledelete(p80_handle(h)) 'trouble deleting handles' ;
      if(magpie.modelstat <= 2,
		    p80_handle(h) = 0;
        	p80_modelstat(t,h) = magpie.modelstat;
		);

        if(p80_counter(h)<= s80_maxiter and magpie.modelstat ne 2,
		    if(magpie.modelstat = 13,
            	display "WARNING: Modelstat 13 | retry without Conopt4 pre-processing";
		    	magpie.optfile = 2;
		    	magpie.handle = p80_handle(h);
         	 	execute_loadhandle magpie;
	        	solve magpie USING nlp MINIMIZING vm_cost_glo;
	        	magpie.optfile = s80_optfile ;
		    	p80_counter(h) = p80_counter(h) + 1;
          		p80_modelstat(t,h) = magpie.modelstat;
		    else
		    	magpie.handle = p80_handle(h);
        		execute_loadhandle magpie;
*				display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;
		    	solve magpie USING nlp MINIMIZING vm_cost_glo ;
		    	p80_counter(h) = p80_counter(h) + 1;
        		p80_modelstat(t,h) = magpie.modelstat;
		    );
        if(magpie.modelStat > 2 and magpie.modelStat ne 7 and p80_counter(h) = s80_maxiter+1,
          p80_resolve(h) = yes;
          );
        );

      	h2(h) = no;
		i2(i) = no;
		j2(j) = no;

      execerror = 0;
    );
  display$readyCollect(p80_handle) 'Problem waiting for next instance to complete';
  until card(p80_handle) = 0 OR smax(h, p80_counter(h)) > s80_maxiter+1;
  execerror = 0;

  if (smax(h,p80_modelstat(t,h)) > 2 and smax(h,p80_modelstat(t,h)) ne 7,
    Execute_Unload "fulldata.gdx";
    abort "no feasible solution found!";
  );

* handleSubmit does not work as expected. Does not restart from saved state.
* Therefore, solve statements are used.
* display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;

***************end solve loop***************
