*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*Determine level of abatement depending on C price
*There are 200 abatement steps. Each step is 5 USD/tC. 
*Options at zero cost are in the first step
i57_mac_step(t,i) = min(201, ceil(im_pollutant_prices(t,i,"co2_c") / 5) + 1);

*Calculate technical mitigation depending on i57_mac_step
im_maccs_mitigation(t,i,emis_source,pollutants) = 0;

im_maccs_mitigation(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step(t,i)),
              f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps));

im_maccs_mitigation(t,i,emis_source_awms_manure_n2o,"n2o_n_direct") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step(t,i)),
              f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps));

im_maccs_mitigation(t,i,emis_source_rice_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step(t,i)),
              f57_maccs_ch4(t,i,"rice_ch4",maccs_steps));

im_maccs_mitigation(t,i,emis_source_ent_ferm_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step(t,i)),
              f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps));

im_maccs_mitigation(t,i,emis_source_awms_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step(t,i)),
              f57_maccs_ch4(t,i,"awms_ch4",maccs_steps));


*Abatement options at zero cost are in the first step. Therefore maccs_steps.off (pos-1) is used.
p57_maccs_costs_integral(t,i,emis_source,pollutants) = 0;
loop(maccs_steps,
    p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") + maccs_steps.off*5;

    p57_maccs_costs_integral(t,i,emis_source_awms_manure_n2o,"n2o_n_direct")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_awms_manure_n2o,"n2o_n_direct") + maccs_steps.off*5;

    p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4") + maccs_steps.off*5;

    p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4") + maccs_steps.off*5;

    p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4") + maccs_steps.off*5;
);

display
i57_mac_step
p57_maccs_costs_integral
;
