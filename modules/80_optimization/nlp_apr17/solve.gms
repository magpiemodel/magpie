*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************
s80_counter = 0;
p80_modelstat(t) = 1;

repeat(

  solve magpie USING nlp MINIMIZING vm_cost_glo;

* if solve stopped with an error, try it again with conopt3
    if((magpie.modelstat = 13),
      display "WARNING: Modelstat 13 | retry with CONOPT3!";
      option nlp = conopt;
      solve magpie USING nlp MINIMIZING vm_cost_glo;
      option nlp = conopt4;
    );

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
