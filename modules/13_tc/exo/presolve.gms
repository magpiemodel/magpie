*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc13_land(i,"pastr") = sum(cell(i,j),pcm_land(j,"past"));
pc13_land(i,"crop") = sum(cell(i,j),pcm_land(j,"crop"));

if (smin((h,tautype), f13_tau_scenario(t,h,tautype)) <= 0,
  abort "tau value of 0 detected in at least one region!";
);

vm_tau.fx(h,tautype) = f13_tau_scenario(t,h,tautype);

* The costs are shifted over 15 years (exponent 15) to reflect the average
* time it takes investments in tc to pay off.

p13_cost_tc(i,tautype) = pc13_land(i,tautype) * i13_tc_factor(t)
                     * sum(supreg(h,i), vm_tau.l(h,tautype))**i13_tc_exponent(t)
                     * (1+pm_interest(t,i))**15;

p13_tech_cost(i,tautype) = (sum(supreg(h,i),vm_tau.l(h,tautype)/pcm_tau(h,tautype))-1) * p13_cost_tc(i,tautype)
                               * pm_interest(t,i)/(1+pm_interest(t,i));

vm_tech_cost.fx(i) = sum(tautype, p13_tech_cost(i,tautype));
