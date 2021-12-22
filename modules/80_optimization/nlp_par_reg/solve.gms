*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************


p80_counter(h) = 0;
p80_modelstat(t,h) = 14;

*** solver settings

option nlp = conopt4;
magpie.solvelink = 3;
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

h2(h) = no;
i2(i) = no;
j2(j) = no;

*submission loop
loop(i,
  	i2(i) = yes;
	h2(i) = yes;
	loop(i2, j2(j) = yes$cell(i2,j));
	display i2;
	display h2;
	display j2;  
	solve magpie USING nlp MINIMIZING vm_cost_glo ;
*	display j2;
*	display i2;
  h2(h) = no;
	i2(i) = no;
	j2(j) = no;
	p80_handle(i) = magpie.handle;
);

*collection loop
repeat
  loop(i$p80_handle(i),
    if(handleStatus(p80_handle(i)) = 2,
	    p80_counter(i) = p80_counter(i) + 1;
      	s80_resolve = 1;
		
		magpie.handle = p80_handle(i);
		execute_loadhandle magpie;
		magpie.modelStat$(magpie.modelStat=NA) = 13;

		s80_modelstat_previter = p80_modelstat(t,i);
		p80_modelstat(t,i) = magpie.modelStat;
		s80_optfile_previter = magpie.optfile;
       	magpie.optfile = s80_optfile;
		
		i2(i) = yes;
      	h2(i) = yes$;
      	loop(i2, j2(j) = yes$cell(i2,j));
      	display h2;
      	s80_counter = sum(i2,p80_counter(i2));
      	display s80_counter;
      	display magpie.modelStat;
  		
  		if((p80_counter(i) >= s80_maxiter AND magpie.modelStat > 2 AND magpie.modelStat ne 7),
      		display "No feasible solution found. Writing LST file.";
      		option AsyncSolLst=1;
      		display$handlecollect(p80_handle(h)) 're-collect';
      		option AsyncSolLst=0;
      		s80_resolve = 0;
			);

	    display$handledelete(p80_handle(i)) 'trouble deleting handles' ;

		if(magpie.modelStat <= 2 AND magpie.numNOpt <= s80_num_nonopt_allowed,
		    display "Model status <= 2. Handle cleared.";
		    s80_resolve = 0;
		    p80_handle(i) = 0;
			);
			
		if(s80_resolve = 1,
			display "Resolve"
			if(magpie.modelStat ne s80_modelstat_previter,
	            display "Modelstat > 2 | Retry solve with CONOPT4 default setting";
			    solve magpie USING nlp MINIMIZING vm_cost_glo ;
	   	 	elseif magpie.modelStat = s80_modelstat_previter,
              if(magpie.optfile = s80_optfile_previter,
            	display "Modelstat > 2 | Retry solve without CONOPT4 pre-processing";
		    	magpie.optfile = 2;
	        	solve magpie USING nlp MINIMIZING vm_cost_glo;
		      else	
		        display "Modelstat > 2 | Retry solve with CONOPT3";
      			option nlp = conopt;
      			solve magpie USING nlp MINIMIZING vm_cost_glo;
      			option nlp = conopt4;
            	);
              );
		  	execerror = 0;         	
		  	if(magpie.handle = 0,
		  		display "Problem. Handle is zero despite resolve. Setting handle to 1 for continuation.";
		  		magpie.handle = 1;
		  		);
		  	p80_handle(i) = magpie.handle;
         	);
     	h2(h) = no;
		i2(i) = no;
		j2(j) = no;
		);
	);
	display$readyCollect(p80_handle,INF) 'Problem waiting for next instance to complete';
until card(p80_handle) = 0 OR smax(h, p80_counter(i)) >= s80_maxiter;

if (smax(h,p80_modelstat(t,i)) > 2 and smax(h,p80_modelstat(t,i)) ne 7,
    Execute_Unload "fulldata.gdx";
    abort "No feasible solution found!";
);

* handleSubmit does not work as expected. Does not restart from saved state.
* Therefore, solve statements are used.
* display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;

***************end solve loop***************
