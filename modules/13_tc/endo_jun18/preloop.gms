*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$ifthen "%c13_tccost%" == "mixed"
i13_tc_factor(t,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen13_to_dev(scen13,dev), f13_tc_factor(t,scen13)));
i13_tc_exponent(t,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen13_to_dev(scen13,dev), f13_tc_exponent(t,scen13)));
$else
i13_tc_factor(t,i) = f13_tc_factor(t,"%c13_tccost%");
i13_tc_exponent(t,i) = f13_tc_exponent(t,"%c13_tccost%");
$endif

pc13_tau(i)      = fm_tau1995(i);
pc13_tcguess(i)  = f13_tcguess(i);

p13_tech_cost_past(t,i) = 0;
