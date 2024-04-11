*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$if "%c57_macc_version%" == "PBL_2007" s57_step_length = 5;
$if "%c57_macc_version%" == "PBL_2019" s57_step_length = 20;
$if "%c57_macc_version%" == "PBL_2022" s57_step_length = 20;

$ontext
Determine level of GHG emission abatement depending on GHG prices.
There are 201 abatement steps. Each step is 5 USD per tC eq in case of PBL_2007 and
20 USD per tC eq in case of PBL_2019.
Since the GHG prices are in USD per ton N and USD per ton CH4, conversion to USD per ton C eq is needed.
In this realization, the IPCC AR4 global warming potential factor for N2O (298) and CH4 (25) are used because
PBL used these parameters to convert USD per ton N2O and USD per ton CH4 into USD per ton C eq.
$offtext

i57_mac_step_n2o(t,i,emis_source) = min(201, ceil(im_pollutant_prices(t,i,"n2o_n_direct",emis_source)/298*28/44*44/12 / s57_step_length) + 1);
i57_mac_step_ch4(t,i,emis_source) = min(201, ceil(im_pollutant_prices(t,i,"ch4",emis_source)/25*44/12 / s57_step_length) + 1);


loop(t,

  if(m_year(t) > sm_fix_SSP2,

    if (s57_maxmac_n_soil >= 0, i57_mac_step_n2o(t,i,emis_source_inorg_fert_n2o) = s57_maxmac_n_soil);
    if (s57_maxmac_n_awms >= 0, i57_mac_step_n2o(t,i,emis_source_awms_n2o) = s57_maxmac_n_awms);
    if (s57_maxmac_ch4_rice >= 0, i57_mac_step_ch4(t,i,emis_source_rice_ch4) = s57_maxmac_ch4_rice);
    if (s57_maxmac_ch4_entferm >= 0, i57_mac_step_ch4(t,i,emis_source_ent_ferm_ch4) = s57_maxmac_ch4_entferm);
    if (s57_maxmac_ch4_awms >= 0, i57_mac_step_ch4(t,i,emis_source_awms_ch4) = s57_maxmac_ch4_awms);

  );
);

*Calculate technical mitigation depending on i57_mac_step_n2o and i57_mac_step_ch4.
*At zero GHG prices i57_mac_step_n2o and i57_mac_step_ch4 are set to 1.
*Technical mitigation should be zero at zero GHG prices.
*There the following calculations are only executed for ord(maccs_steps) > 1

im_maccs_mitigation(t,i,emis_source,pollutants) = 0;

im_maccs_mitigation(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_n2o(t,i,emis_source_inorg_fert_n2o) AND ord(maccs_steps) > 1),
              f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps));

im_maccs_mitigation(t,i,emis_source_awms_n2o,"n2o_n_direct") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_n2o(t,i,emis_source_awms_n2o) AND ord(maccs_steps) > 1),
              f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps));

im_maccs_mitigation(t,i,emis_source_rice_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_ch4(t,i,emis_source_rice_ch4) AND ord(maccs_steps) > 1),
              f57_maccs_ch4(t,i,"rice_ch4",maccs_steps));

im_maccs_mitigation(t,i,emis_source_ent_ferm_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_ch4(t,i,emis_source_ent_ferm_ch4) AND ord(maccs_steps) > 1),
              f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps));

im_maccs_mitigation(t,i,emis_source_awms_ch4,"ch4") =
        sum(maccs_steps$(ord(maccs_steps) eq i57_mac_step_ch4(t,i,emis_source_awms_ch4) AND ord(maccs_steps) > 1),
              f57_maccs_ch4(t,i,"awms_ch4",maccs_steps));

$ontext
The costs associated with technical abatement of GHG emissions are reflected by the area under the mac curve, i.e. the integral.
Abatement options at zero cost are in the first step. Therefore an offset of -1 is used.
Note that the emissions before mitigation, which need to be part of the integral calculation but are not available in preloop,
are multiplied with p57_maccs_costs_integral during optimization (see equations).

Illustrative example for CH4: Abatement is 0.14 percent at 0$/tC, 0.15 percent at 5 and 10 $/tC, and 0.16 percent at 15 $/tC.
Emissions before technical mitigation are assumed 1 t CH4.

step 1                      0 mio $   0 mio $
step 2  (0.15-0.14) * 1 tCH4 * 5$/tC*12/44*28   0.38 mio $  0.38 mio $
step 3  (0.15-0.15) * 1 tCH4 * 10$/tC*12/44*28  0 mio $   0.38 mio $
step 4  (0.16-0.15) * 1 tCH4 * 15$/tC*12/44*28  1.15 mio $  1.53 mio $

$offtext

p57_maccs_costs_integral(t,i,emis_source,pollutants) = 0;

loop(maccs_steps$(ord(maccs_steps) > 1),
    p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct")$(ord(maccs_steps) <= i57_mac_step_n2o(t,i,emis_source_inorg_fert_n2o)) =
    p57_maccs_costs_integral(t,i,emis_source_inorg_fert_n2o,"n2o_n_direct") +
    (f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps) - f57_maccs_n2o(t,i,"inorg_fert_n2o",maccs_steps-1))*(ord(maccs_steps)-1)*s57_step_length;

    p57_maccs_costs_integral(t,i,emis_source_awms_n2o,"n2o_n_direct")$(ord(maccs_steps) <= i57_mac_step_n2o(t,i,emis_source_awms_n2o)) =
    p57_maccs_costs_integral(t,i,emis_source_awms_n2o,"n2o_n_direct") +
    (f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps) - f57_maccs_n2o(t,i,"awms_manure_n2o",maccs_steps-1))*(ord(maccs_steps)-1)*s57_step_length;

    p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step_ch4(t,i,emis_source_rice_ch4)) =
    p57_maccs_costs_integral(t,i,emis_source_rice_ch4,"ch4") +
    (f57_maccs_ch4(t,i,"rice_ch4",maccs_steps) - f57_maccs_ch4(t,i,"rice_ch4",maccs_steps-1))*(ord(maccs_steps)-1)*s57_step_length;

    p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step_ch4(t,i,emis_source_ent_ferm_ch4)) =
    p57_maccs_costs_integral(t,i,emis_source_ent_ferm_ch4,"ch4") +
    (f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps) - f57_maccs_ch4(t,i,"ent_ferm_ch4",maccs_steps-1))*(ord(maccs_steps)-1)*s57_step_length;

    p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4")$(ord(maccs_steps) <= i57_mac_step_ch4(t,i,emis_source_awms_ch4)) =
    p57_maccs_costs_integral(t,i,emis_source_awms_ch4,"ch4") +
    (f57_maccs_ch4(t,i,"awms_ch4",maccs_steps) - f57_maccs_ch4(t,i,"awms_ch4",maccs_steps-1))*(ord(maccs_steps)-1)*s57_step_length;
);

*Conversion from USD per ton C to USD per ton N and USD per ton CH4, using the old IPCC AR4 GWP factors.
p57_maccs_costs_integral(t,i,emis_source,"n2o_n_direct") = p57_maccs_costs_integral(t,i,emis_source,"n2o_n_direct")*12/44*298*44/28;
p57_maccs_costs_integral(t,i,emis_source,"ch4") = p57_maccs_costs_integral(t,i,emis_source,"ch4")*12/44*25;
