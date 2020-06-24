*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


if (ord(t) = 1,


i38_variable_costs(i2,kcr) = f38_fac_req_per_ton(kcr) * (1-s38_capital_cost_share) * (1-s38_mi_start);

* Estimate capital stock based on capital remuneration

i38_capital_need(i,kcr,"mobile") = f38_fac_req_per_ton(kcr) * s38_capital_cost_share / pm_interest(i) * (1-s38_immobile);
i38_capital_need(i,kcr,"immobile") = f38_fac_req_per_ton(kcr)*s38_capital_cost_share / pm_interest(i) * s38_immobile;
i38_capital_need(i,perennials38,"mobile") = f38_fac_req_per_ton(perennials38)* s38_capital_cost_share / pm_interest(i) * (1-s38_immobile_perennials);
i38_capital_need(i,perennials38,"immobile") = f38_fac_req_per_ton(perennials38)* s38_capital_cost_share / pm_interest(i) * s38_immobile_perennials;

p38_capital_immobile(t,j,kcr)   = sum(cell(i,j), i38_capital_need(i,kcr,"immobile")*pm_croparea_start(j,kcr)*f38_region_yield(i,kcr)* fm_tau1995(i));
p38_capital_mobile(t,j)   = sum((cell(i,j),kcr), i38_capital_need(i,kcr,"mobile")*pm_croparea_start(j,kcr)*f38_region_yield(i,kcr)* fm_tau1995(i));

vm_prod.l(j,kcr)=sum(cell(i,j),pm_croparea_start(j,kcr)*f38_region_yield(i,kcr)* fm_tau1995(i));

  );


*if management intensity is also considered a variable
*v38_mi.fx(i) = 0.47;
*basic constraints based on normal sticky_feb18 previous runs
*v38_capital.up(j,kcr,mobil38)=5e5;
*v38_investment.up(j,kcr,mobil38)=5e5;

* Relocation of mobile capital between crops is possible between crops,
* and between exisiting cropland and new cropland within a cell.
* The latter gives also incentive for expansion in cells with preexisting
* farmland.

v38_capital_mobile.up(j)=p38_capital_mobile(t,j);

* The next constraint replaces capital intensity of sunk capital.
v38_capital_immobile.up(j,kcr)=p38_capital_immobile(t,j,kcr);

v38_investment_immobile.up(j,kcr,mobil38)=1e7;
v38_investment_mobile.up(j,kcr,mobil38)=1e7;
