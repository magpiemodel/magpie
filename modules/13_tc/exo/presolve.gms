*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc13_land(h) = sum((supreg(h,i),cell(i,j)),pcm_land(j,"crop"));

vm_tau.fx(h) = f13_tau_scenario(t,h);

p13_cost_tc(h) = pc13_land(h) * i13_tc_factor(t,h)
                     * vm_tau.l(h)**i13_tc_exponent(t,h)
                     * (1+pm_interest(t,h))**15;

p13_tech_cost_annuity(h) = (vm_tau.l(h)/pcm_tau(h)-1) * p13_cost_tc(h)
                               * pm_interest(t,h)/(1+pm_interest(t,h));

vm_tech_cost.fx(i) = sum(supreg(h,i),(p13_tech_cost_annuity(h) + p13_tech_cost_past(t,h))/sum(supreg(h,i), 1));
