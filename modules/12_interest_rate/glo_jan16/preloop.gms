*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*******Income Country Grouping based on World Bank definitions
t_to_i_to_dev(t,i,dev) = no;
t_to_i_to_dev(t,i,"lic") = yes$(im_gdp_pc_ppp(t,i) <= 1045);
t_to_i_to_dev(t,i,"mic") = yes$(im_gdp_pc_ppp(t,i) > 1045 AND im_gdp_pc_ppp(t,i) < 12746);
t_to_i_to_dev(t,i,"hic") = yes$(im_gdp_pc_ppp(t,i) >= 12746);

$ifthen "%c12_interest_rate%" == "coupling" p12_interest(t,i) = f12_interest_coupling(t);
$elseif "%c12_interest_rate%" == "mixed" p12_interest(t,i) = sum(t_to_i_to_dev("y1995",i,dev), sum(scen12_to_dev(scen12,dev), f12_interest(t,scen12)));
$else p12_interest(t,i) = f12_interest(t,"%c12_interest_rate%");
$endif
