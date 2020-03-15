*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
**************start solve loop**************

s21_counter = 0; 

while(abs(sum((i2,k_trade), v21_cost_trade_bal.l(i2,k_trade))) > 0 AND s21_counter <= s21_maxiter,
    s21_counter = s21_counter + 1;
    display "Warning: There are trade imbalances for timber. Restarting solve with reduced timber demand!";
    pm_demand_ext(t,i,"wood") = pm_demand_ext(t,i,"wood") + v21_cost_trade_bal.l(i,"wood");
    pm_demand_ext(t,i,"woodfuel") = pm_demand_ext(t,i,"woodfuel") + v21_cost_trade_bal.l(i,"woodfuel");
    solve magpie USING nlp MINIMIZING vm_cost_glo;
);
