**************start solve loop**************
s80_counter = 0;
p80_modelstat(t) = 1;

repeat(

  solve magpie USING nlp MINIMIZING vm_cost_glo;

  p80_modelstat(t) = magpie.modelstat;

  display "vm_cost_glo.l";
  display vm_cost_glo.l;


* write extended run information in list file in the case that the final solution is infeasible
  if((s80_counter >= s80_maxiter and p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
    magpie.solprint = 1
  );

  display s80_counter;

  until (p80_modelstat(t) <= 2 or s80_counter >= s80_maxiter)
);

if ((p80_modelstat(t) < 3),
  put_utility 'shell' / 'mv magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((p80_modelstat(t) > 2 and p80_modelstat(t) ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

***************end solve loop***************
