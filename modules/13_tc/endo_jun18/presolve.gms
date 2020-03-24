*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if(m_year(t) <= sm_fix_SSP2,
 i13_tc_factor(t,i) = f13_tc_factor(t,"medium");
 i13_tc_exponent(t,i) = f13_tc_exponent(t,"medium");
else
$ifthen "%c13_tccost%" == "mixed"
  i13_tc_factor(t,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen13_to_dev(scen13,dev), f13_tc_factor(t,scen13)));
  i13_tc_exponent(t,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen13_to_dev(scen13,dev), f13_tc_exponent(t,scen13)));
$else
  i13_tc_factor(t,i) = f13_tc_factor(t,"%c13_tccost%");
  i13_tc_exponent(t,i) = f13_tc_exponent(t,"%c13_tccost%");
$endif
);

pc13_tech_cost_past(i) = p13_tech_cost_past(t,i);

pc13_land(i) = sum(cell(i,j),pcm_land(j,"crop"));

if (sum(sameas(t_past,t),1) = 1,
	vm_tau.lo(i) =    f13_tau_historical(t,i);
else
	vm_tau.lo(i) =    pc13_tau(i);
);

	vm_tau.up(i) =  2*pc13_tau(i);

* educated guess for vm_tau.l:
	vm_tau.l(i) = pc13_tau(i)*(1+pc13_tcguess(i))**m_yeardiff(t);

	vm_tech_cost.up(i) = 10e9;
