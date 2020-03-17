*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

s21_counter = 0;

p21_prices(t,i,k_trade) = q21_trade_glo.m(k_trade) + q21_trade_reg.m(i,k_trade);
p21_prices_reg(t,i,k_trade) = q21_trade_reg.m(i,k_trade);
p21_prices_glo(t,k_trade) = q21_trade_glo.m(k_trade);
*display q21_trade_glo.m;
*display q21_trade_reg.m;
*display q16_supply_forestry.m;
*display p21_prices;

while(floor(smax((i,k_trade), v21_supply_missing.l(i,k_trade))) > 0 AND s21_counter <= s21_maxiter,
    s21_counter = s21_counter + 1;
    p21_criterion = floor(smax((i,k_trade), v21_supply_missing.l(i,k_trade)));
	display p21_criterion;
	display "Warning: There are trade imbalances for timber. Restarting solve with adjusted timber demand!";
    pm_demand_ext(t,i,"wood") = pm_demand_ext(t,i,"wood") + v21_supply_missing.l(i,"wood");
    pm_demand_ext(t,i,"woodfuel") = pm_demand_ext(t,i,"woodfuel") + v21_supply_missing.l(i,"woodfuel");

    p21_timder_adjustment_ratio(t,i,"wood") = pm_demand_ext(t,i,"wood")/pm_demand_ext_original(t,i,"wood");
    p21_timder_adjustment_ratio(t,i,"woodfuel") = pm_demand_ext(t,i,"woodfuel")/pm_demand_ext_original(t,i,"woodfuel");

    if(p21_timder_adjustment_ratio(t,i,"wood") < 0.75 OR p21_timder_adjustment_ratio(t,i,"woodfuel") < 0.75),
    display "Warning: Ratio between prescribed demand and adjusted demand in some regions diverge heavily!";
    display p21_timder_adjustment_ratio;
    );

	s21_counter2 = 0;
	repeat(
      s21_counter2 = s21_counter2 + 1;
	  solve magpie USING nlp MINIMIZING vm_cost_glo;
* if solve stopped with an error, try it again with conopt3
	  if((magpie.modelstat = 13),
      	display "WARNING: Modelstat 13 | retry with CONOPT3!";
      	option nlp = conopt;
        solve magpie USING nlp MINIMIZING vm_cost_glo;
      	option nlp = conopt4;
       );
* write extended run information in list file in the case that the final solution is infeasible
  if((s21_counter2 >= (s21_maxiter2-1) and magpie.modelstat > 2 and magpie.modelstat ne 7),
    magpie.solprint = 1
  );
  until (magpie.modelstat <= 2 or s21_counter2 >= s21_maxiter2)
);

if ((magpie.modelstat < 3),
  put_utility 'shell' / 'mv -f magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((magpie.modelstat > 2 and magpie.modelstat ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

);
