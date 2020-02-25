*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc13_tech_cost_past(i) = p13_tech_cost_past(t,i);

pc13_land(i) = sum(cell(i,j),pcm_land(j,"crop"));

if (sum(sameas(t_past,t),1) = 1,
$ontext
	vm_tau.fx(i) = f13_tau_historical(t,i); 
	
	v13_cost_tc.fx(i) = pc13_land(i) * i13_tc_factor(t,i)
                     * vm_tau.l(i)**i13_tc_exponent(t,i)
                     * (1+pm_interest(i))**15;

	v13_tech_cost_annuity.fx(i) = (vm_tau.l(i)/pc13_tau(i)-1) * v13_cost_tc.l(i)
                               * pm_interest(i)/(1+pm_interest(i));

vm_tech_cost.fx(i) = v13_tech_cost_annuity.l(i) + pc13_tech_cost_past(i);
$offtext
	vm_tau.lo(i) =    f13_tau_historical(t,i);

else
	vm_tau.lo(i) =    pc13_tau(i);
);

	vm_tau.up(i) =  2*pc13_tau(i);

* educated guess for vm_tau.l:
	vm_tau.l(i) = pc13_tau(i)*(1+pc13_tcguess(i))**m_yeardiff(t);

	vm_tech_cost.up(i) = 10e9;
