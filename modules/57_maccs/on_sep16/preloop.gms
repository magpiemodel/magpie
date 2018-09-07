*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*Abatement options are in 5 USD/tC steps; options at zero price are in the first step
i57_mac_step(t,i) = min(201, ceil(im_pollutant_prices(t,i,"co2_c") / 5) + 1);

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


p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") = f57_maccs_n2o(t,i,"inorg_fert_n2o","1");
p57_maccs_costs_integral(t,i,emis_source_awms_manure_n2o,"n2o_n_direct") = f57_maccs_n2o(t,i,"awms_manure_n2o","1");
p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4") = f57_maccs_ch4(t,i,"rice_ch4","1");
p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4") = f57_maccs_ch4(t,i,"ent_ferm_ch4","1");
p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4") = f57_maccs_ch4(t,i,"awms_ch4","1");

loop(maccs_steps$(ord(maccs_steps) > 1),
    p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") +
    (f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps) - f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps-1))*(ord(maccs_steps)-1)*5;

    p57_maccs_costs_integral(t,i,emis_source_awms_manure_n2o,"n2o_n_direct")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_awms_manure_n2o,"n2o_n_direct") +
    (f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps) - f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps-1))*(ord(maccs_steps)-1)*5;

    p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4") +
    (f57_maccs_ch4(t,i,"rice_ch4",maccs_steps) - f57_maccs_ch4(t,i,"rice_ch4",maccs_steps-1))*(ord(maccs_steps)-1)*5;

    p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4") +
    (f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps) - f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps-1))*(ord(maccs_steps)-1)*5;

    p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step(t,i)) =
    p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4") +
    (f57_maccs_ch4(t,i,"awms_ch4",maccs_steps) - f57_maccs_ch4(t,i,"awms_ch4",maccs_steps-1))*(ord(maccs_steps)-1)*5;
);
