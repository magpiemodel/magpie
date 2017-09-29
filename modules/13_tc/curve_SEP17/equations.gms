*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q13_tech_cost(i2) .. vm_tech_cost(i2) =e= v13_tech_cost_annuity(i2) + pc13_tech_cost_past(i2);

 q13_tech_cost_annuity(i2).. v13_tech_cost_annuity(i2) =e= (vm_tau(i2)/pc13_tau(i2)-1)*v13_cost_tc(i2)/pm_annuity_due(i2);

 q13_cost_tc(i2) .. v13_cost_tc(i2) =e= v13_cost_tc_agg * (1+pm_interest(i2))**15);

 q13_cost_tc_part1(i2)..    v13_cost_tc_part1(i2) =e= sum(ct,i13_land(i2)*i13_tc_factor(ct,i2))*vm_tau(i2)**i13_tc_exponent(i2);

 q13_cost_tc_part2(i2)..     v13_cost_tc_part2(i2) =g= sum(ct, i13_land(i2)*i13_tc_factor(ct,i2)/500 * (vm_tau(i2)**(i13_tc_exponent(i2) + 2))
                                                                           - i13_tc_factor(i2)/500 * (1.6**(i13_tc_exponent(i2) + 2));
*q13_cost_tc_part2(i2)..     v13_cost_tc_part2(i2) =e= i13_tc_factor(i2)/500*(vm_tau(i2)**(i13_tc_exponent(i2)+2));

 q13_cost_tc_agg(i2)..       v13_cost_tc_agg(i2)   =e= v13_cost_tc_part1(i2) + v13_cost_tc_part2(i2);
