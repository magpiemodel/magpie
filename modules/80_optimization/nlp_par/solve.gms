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
  loop(h$p80_handle(h),
    if(handleStatus(p80_handle(h)) = 2,
	    p80_counter(h) = p80_counter(h) + 1;
      	s80_resolve = 1;
		
		magpie.handle = p80_handle(h);
		execute_loadhandle magpie;
		
		s80_modelstat_previter = p80_modelstat(t,h);
		p80_modelstat(t,h) = magpie.modelstat;
		s80_optfile_previter = magpie.optfile;
       	magpie.optfile = s80_optfile;
		
		h2(h) = yes;
      	i2(i) = yes$supreg(h,i);
      	loop(i2, j2(j) = yes$cell(i2,j));
      	display h2;
      	s80_counter = sum(h2,p80_counter(h2));
      	display s80_counter;
      	display magpie.modelstat;
  		
		if(magpie.modelStat <= 2 AND magpie.numNOpt <= s80_num_nonopt_allowed,
		    s80_resolve = 0;
			);
  		
  		if((p80_counter(h) >= (s80_maxiter) and magpie.modelStat > 2 and magpie.modelStat ne 7),
      		option AsyncSolLst=1;
      		display$handlecollect(p80_handle(h)) 're-collect';
      		option AsyncSolLst=0;
      		s80_resolve = 0;
			);
	    
	    display$handledelete(p80_handle(h)) 'trouble deleting handles' ;
	    p80_handle(h) = 0;

		  if(s80_resolve = 1,
			if(magpie.modelstat ne s80_modelstat_previter,
	            display "Modelstat > 2 | Retry solve with CONOPT4 default setting";
			    solve magpie USING nlp MINIMIZING vm_cost_glo ;
			    p80_handle(h) = magpie.handle;
	   	 	elseif magpie.modelstat = s80_modelstat_previter,
              if(magpie.optfile = s80_optfile_previter,
            	display "Modelstat > 2 | Retry solve without CONOPT4 pre-processing";
		    	magpie.optfile = 2;
	        	solve magpie USING nlp MINIMIZING vm_cost_glo;
		    	p80_handle(h) = magpie.handle;
		      else	
		        display "Modelstat > 2 | Retry solve with CONOPT3";
      			option nlp = conopt;
      			solve magpie USING nlp MINIMIZING vm_cost_glo;
      			option nlp = conopt4;
		    	p80_handle(h) = magpie.handle;
            	);
              );
         	);
     	h2(h) = no;
		i2(i) = no;
		j2(j) = no;
	  	execerror = 0;
		);
	);
  display$readyCollect(p80_handle) 'Problem waiting for next instance to complete';
until card(p80_handle) = 0 OR smax(h, p80_counter(h)) >= s80_maxiter;

if (smax(h,p80_modelstat(t,h)) > 2 and smax(h,p80_modelstat(t,h)) ne 7,
    Execute_Unload "fulldata.gdx";
    abort "no feasible solution found!";
);

* handleSubmit does not work as expected. Does not restart from saved state.
* Therefore, solve statements are used.
* display$handleSubmit(p80_handle(h)) 'trouble resubmitting handles' ;

***************end solve loop***************
