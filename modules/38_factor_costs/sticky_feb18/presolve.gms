*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*if (sum(sameas(t_past,t),1) = 1,
if (ord(t) = 1,


i38_variable_costs(i2,kcr) = f38_fac_req_per_ton(kcr) * (1-s38_capital_cost_share) * (1-s38_mi_start);
*i38_variable_costs(i2,kcr) = f38_fac_req_per_ton(kcr) * (1-s38_capital_cost_share);

* Estimate capital stock based on capital remuneration

  i38_capital_need(i,kcr,"mobile") = f38_fac_req_per_ton(kcr) * s38_capital_cost_share / pm_interest(i) * (1-s38_immobile);
  i38_capital_need(i,kcr,"immobile") = f38_fac_req_per_ton(kcr)*s38_capital_cost_share / pm_interest(i) * s38_immobile;
  i38_capital_need(i,perennials38,"mobile") = f38_fac_req_per_ton(perennials38)* s38_capital_cost_share / pm_interest(i) * (1-s38_immobile_perennials);
  i38_capital_need(i,perennials38,"immobile") = f38_fac_req_per_ton(perennials38)* s38_capital_cost_share / pm_interest(i) * s38_immobile_perennials;

  p38_capital_intensity(t,j,kcr) = sum(cell(i,j), i38_capital_need(i,kcr,"immobile"));
  p38_capital(t,j,kcr,mobil38)   = sum(cell(i,j), i38_capital_need(i,kcr,mobil38)*pm_croparea_start(j,kcr)*f38_region_yield(i,kcr)* fm_tau1995(i));
  vm_prod.l(j,kcr)=sum(cell(i,j),pm_croparea_start(j,kcr)*f38_region_yield(i,kcr)* fm_tau1995(i));
*p38_past_area(j,kcr)=pm_croparea_start(j,kcr);
  );

v38_mi.fx(i2) = 0.47;
*v38_crop_change.lo(j2,kcr)=-s38_AreaLim;
*v38_crop_change.up(j2,kcr)=s38_AreaLim;
