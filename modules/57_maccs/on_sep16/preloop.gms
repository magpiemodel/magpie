*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*Determine level of abatement depending on CH4/N2O_N price
*There are 200 abatement steps. Each step is 5 USD per tC eq. Therefore conversion to USD per tC eq is needed.
*Options at zero cost are in the first step
i57_mac_step_n2o(t,i) = min(201, ceil(im_pollutant_prices(t,i,"n2o_n_direct")/265*28/44*44/12 / 5) + 1);
i57_mac_step_ch4(t,i) = min(201, ceil(im_pollutant_prices(t,i,"ch4")/28*44/12 / 5) + 1);

*Calculate technical mitigation depending on i57_mac_step
im_maccs_mitigation(t,i,emis_source,pollutants) = 0;

im_maccs_mitigation(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_n2o(t,i)),
              f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps));

im_maccs_mitigation(t,i,emis_source_awms_manure_n2o,"n2o_n_direct") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_n2o(t,i)),
              f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps));

im_maccs_mitigation(t,i,emis_source_rice_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_ch4(t,i)),
              f57_maccs_ch4(t,i,"rice_ch4",maccs_steps));

im_maccs_mitigation(t,i,emis_source_ent_ferm_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_ch4(t,i)),
              f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps));

im_maccs_mitigation(t,i,emis_source_awms_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_ch4(t,i)),
              f57_maccs_ch4(t,i,"awms_ch4",maccs_steps));


*Abatement options at zero cost are in the first step. Therefore an offset of -1 is used.
*Conversion from USD per tC eq to USD per t CH4/N2O_N
p57_maccs_costs_n2o(t,i) = (i57_mac_step_n2o(t,i)-1) *5 *12/44*265*44/28;
p57_maccs_costs_ch4(t,i) = (i57_mac_step_ch4(t,i)-1) *5 *12/44*28;

display
i57_mac_step_n2o
i57_mac_step_ch4
p57_maccs_costs_n2o
p57_maccs_costs_ch4
;
