*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc13_land(i) = sum(cell(i,j), pcm_land(j,"crop"));

vm_tau.fx(h) = f13_tau_scenario(t,h);

* The costs are shifted over 15 years (exponent 15) to reflect the average
* time it takes investments in tc to pay off.

p13_cost_tc(i) = pc13_land(i) * i13_tc_factor(t)
                     * sum(supreg(h,i), vm_tau.l(h))**i13_tc_exponent(t)
                     * (1+pm_interest(t,i))**15;

vm_tech_cost.fx(i) = (sum(supreg(h,i),vm_tau.l(h)/pcm_tau(h))-1) * p13_cost_tc(i)
                               * pm_interest(t,i)/(1+pm_interest(t,i));
