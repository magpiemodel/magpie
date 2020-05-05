*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc13_land(i) = sum(cell(i,j),pcm_land(j,"crop"));

vm_tau.fx(i) = f13_tau_scenario(t,i);

p13_cost_tc(i) = pc13_land(i) * i13_tc_factor(t,i)
                     * vm_tau.l(i)**i13_tc_exponent(t,i)
                     * (1+pm_interest(i))**15;

p13_tech_cost_annuity(i) = (vm_tau.l(i)/pc13_tau(i)-1) * p13_cost_tc(i)
                               * pm_interest(i)/(1+pm_interest(i));

vm_tech_cost.fx(i) = p13_tech_cost_annuity(i) + p13_tech_cost_past(t,i);


