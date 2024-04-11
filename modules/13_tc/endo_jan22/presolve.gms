*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


pc13_land(i,"pastr") = sum(cell(i,j),pcm_land(j,"past"));
pc13_land(i,"crop") = sum(cell(i,j),pcm_land(j,"crop"));

if (sum(sameas(t_past,t),1) = 1 AND s13_ignore_tau_historical = 0,
  vm_tau.lo(h,"pastr") =   fm_pastr_tau_hist(t,h);
  vm_tau.lo(h,"crop") =    f13_tau_historical(t,h);
else
  vm_tau.lo(h, tautype) =    pcm_tau(h, tautype);
);

  vm_tau.up(h,tautype) =  2 * pcm_tau(h,tautype);

* educated guess for vm_tau.l:
if(ord(t) = 1,
  vm_tau.l(h,tautype) = pcm_tau(h,tautype);
else
  vm_tau.l(h,tautype) = pcm_tau(h,tautype)*(1+pc13_tcguess(h,tautype))**m_yeardiff(t);
);

vm_tau.up(h,tautype) = 2 * pcm_tau(h,tautype);

if(m_year(t) > sm_fix_SSP2 AND s13_max_gdp_shr <> Inf,

* We constrain tech cost to a defined share of regional GDP to avoid unrealistically
* high endogenous tech investments
  vm_tech_cost.up(i) =
    sum((i_to_iso(i,iso),ct), im_gdp_pc_ppp_iso(ct,iso) * im_pop_iso(ct,iso)) * s13_max_gdp_shr;

* We set the initial solving basis for the tech cost to its upper bound to support the solver in finding
* a proper solution. Without such initial values, the model leave tech cost at 0 and as such ignore tau
* as an efficient part of the optimal solution.
  vm_tech_cost.l(i) = vm_tech_cost.up(i);

);
