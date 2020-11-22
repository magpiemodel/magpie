*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p56_emissions_reg(t,i,emis_source,pollutants) = 0;
poll_gwp100(pollutants) = not poll_gwpstar(pollutants);
*display poll_gwp100;
*display poll_gwpstar;

***fix vm_btm_cell to zero for non-CO2 emissions from land-use change
vm_btm_cell.fx(j,emis_source_cell,pollutants)$(not sameas(pollutants,"co2_c")) = 0;
***fix vm_btm_cell to zero for CO2 emissions from ag. production (non land-use change)
vm_btm_cell.fx(j,emis_source_reg,"co2_c") = 0;
***fix vm_btm_cell to zero for CO2 emissions from beccs (not used)
vm_btm_cell.fx(j,"beccs",pollutants) = 0;

****** Region price share for ghg policy of selective countries:
* Country switch to determine countries for which ghg policy shall be applied.
* In the default case, the ghg policy affects all countries when activated.
p56_country_dummy(iso) = 0;
p56_country_dummy(policy_countries56) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p56_region_price_shr(t_all,i) = sum(i_to_iso(i,iso), p56_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

****select ghg prices
$ifthen "%c56_pollutant_prices%" == "coupling"
 im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices_coupling(t_all,i,pollutants);
$elseif "%c56_pollutant_prices%" == "emulator"
 im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices_emulator(t_all,i,pollutants);
$else
 im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices(t_all,i,pollutants,"%c56_pollutant_prices%") * p56_region_price_shr(t_all,i)
 																				 + f56_pollutant_prices(t_all,i,pollutants,"%c56_pollutant_prices_noselect%") * (1-p56_region_price_shr(t_all,i));
$endif

** Harmonize till 2020
loop(t_all$(m_year(t_all) <= sm_fix_SSP2),
im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices(t_all,i,pollutants,"R2M41-SSP2-NPi") * p56_region_price_shr(t_all,i)
                                        + f56_pollutant_prices(t_all,i,pollutants,"R2M41-SSP2-NPi") * (1-p56_region_price_shr(t_all,i));
);

***save im_pollutant_prices to parameter
p56_pollutant_prices_input(t_all,i,pollutants) = im_pollutant_prices(t_all,i,pollutants);


***limit CH4 and N2O GHG prices based on s56_limit_ch4_n2o_price
*12/44 conversion from USD per tC to USD per tCO2
*28 and 265 Global Warming Potentials from AR5 WG1 CH08 Table 8.7, conversion from USD per tCO2 to USD per tCH4 and USD per tN2O
*44/28 conversion from USD per tN2O to USD per tN
im_pollutant_prices(t_all,i,"ch4")$(im_pollutant_prices(t_all,i,"ch4") > s56_limit_ch4_n2o_price*12/44*28) = s56_limit_ch4_n2o_price*12/44*28;
im_pollutant_prices(t_all,i,"n2o_n_direct")$(im_pollutant_prices(t_all,i,"n2o_n_direct") > s56_limit_ch4_n2o_price*12/44*265*44/28) = s56_limit_ch4_n2o_price*12/44*265*44/28;
im_pollutant_prices(t_all,i,"n2o_n_indirect")$(im_pollutant_prices(t_all,i,"n2o_n_indirect") > s56_limit_ch4_n2o_price*12/44*265*44/28) = s56_limit_ch4_n2o_price*12/44*265*44/28;

***apply reduction factor on CO2 price to account for potential negative side effects
***lowers the economic incentive for CO2 emission reduction (avoided deforestation) and afforestation
im_pollutant_prices(t_all,i,"co2_c") = im_pollutant_prices(t_all,i,"co2_c")*s56_cprice_red_factor;

***phase-in of GHG price over 20 year period; start depends on s56_ghgprice_start
if (s56_ghgprice_phase_in = 1,
im_pollutant_prices(t_all,i,pollutants)$(m_year(t_all) < s56_ghgprice_start) = 0;
im_pollutant_prices(t_all,i,pollutants)$(m_year(t_all) = s56_ghgprice_start) = 0.1*im_pollutant_prices(t_all,i,pollutants);
im_pollutant_prices(t_all,i,pollutants)$(m_year(t_all) = s56_ghgprice_start+5) = 0.2*im_pollutant_prices(t_all,i,pollutants);
im_pollutant_prices(t_all,i,pollutants)$(m_year(t_all) = s56_ghgprice_start+10) = 0.4*im_pollutant_prices(t_all,i,pollutants);
im_pollutant_prices(t_all,i,pollutants)$(m_year(t_all) = s56_ghgprice_start+15) = 0.8*im_pollutant_prices(t_all,i,pollutants);
im_pollutant_prices(t_all,i,pollutants)$(m_year(t_all) >= s56_ghgprice_start+20) = im_pollutant_prices(t_all,i,pollutants);
);
***multiply GHG prices with development state to account for institutional requirements needed for implementing a GHG pricing scheme
im_pollutant_prices(t_all,i,pollutants)$(s56_ghgprice_devstate_scaling = 1) = im_pollutant_prices(t_all,i,pollutants)*im_development_state(t_all,i);

***GHG emission policy
p56_emis_policy(t,i,pollutants,emis_source) = f56_emis_policy("%c56_emis_policy%",pollutants,emis_source);

*reward neg emissions depending on s56_reward_neg_emis
v56_emission_costs_cell_oneoff.lo(j2,emis_cell_one56) = s56_reward_neg_emis;

***construct age-class dependent C price for afforestation incentive
***this is needed because time steps (t) and age-classes (ac) can differ. ac and t_all are always in 5-year time steps.
*For missing years in t_all use C price of previous time step. This step makes sure that C prices for every 5-year time step are available.
loop(t_all$(m_year(t_all)>=s56_ghgprice_start),
	im_pollutant_prices(t_all,i,"co2_c")$(im_pollutant_prices(t_all,i,"co2_c") = 0) = im_pollutant_prices(t_all-1,i,"co2_c");
);
*Linear interpolation of C price for missing time steps
loop(t,
 s56_timesteps = m_yeardiff(t)/5;
  if (s56_timesteps > 1,
   s56_counter = 0;
    repeat(
       s56_counter = s56_counter + 1;
       s56_offset = s56_timesteps-s56_counter;
       im_pollutant_prices(t_all-s56_offset,i,"co2_c")$(m_year(t_all) = m_year(t)) =
       im_pollutant_prices(t-1,i,"co2_c") +
       (im_pollutant_prices(t,i,"co2_c") - im_pollutant_prices(t-1,i,"co2_c"))*s56_counter/(s56_timesteps);
    until s56_counter = s56_timesteps-1);
  );
);
display p56_pollutant_prices_input;
display im_pollutant_prices;
*initialize age-class dependent C price with same C price for all age-classes
p56_c_price_aff(t_all,i,ac) = im_pollutant_prices(t_all,i,"co2_c");
*Shift C prices in age-classes for reflecting foresight.
*e.g. ac5 in 2020 should have the C price of ac0 in 2025, and ac20 in 2020 equals to ac0 in 2040
p56_c_price_aff(t_all,i,ac)$(ord(t_all)+ac.off<card(t_all)) = p56_c_price_aff(t_all+ac.off,i,"ac0");
*limit foresight of C prices to X years; constant C price after X years.
ac_exp(ac)$(ac.off = s56_c_price_exp_aff/5) = yes;
p56_c_price_aff(t_all,i,ac)$(ac.off >= s56_c_price_exp_aff/5) = sum(ac_exp, p56_c_price_aff(t_all,i,ac_exp));
*zero C price before starting year
p56_c_price_aff(t_all,i,ac)$(m_year(t_all)<s56_ghgprice_start) = 0;

display p56_c_price_aff;

*' @code
*' The pollutant price `im_pollutant_prices` should reflect the marginal cost (i.e. the price) 
*' of one additional unit of emission based on the formulation of emission costs
*' in the equation `q56_emission_costs_reg_yearly`.
*'
*' Conceptually, emission costs are obtained by conversion of all GHG emissions to CO2eq, using 
*' AR5 GWP100 factors, and multiplication with the CO2 price. However, for short-lived
*' climate pollutants the alternative GWP* metric (GWPstar hereafter) has been proposed by @Allen_2018.
*' While GWP100 tracks the level of emissions, GWPstar tracks the change of emissions. 
*'
*' For GWP100, the underlying basic formula used for the calculation of emission cost (`poll_gwp100`) is: 
*'
*' `emis_cost(t) = emis(t) * CO2_price(t) * GWP100`
*'
*' First derivative (emis(t) is a variable):
*'
*' `marg_emis_cost(t) = CO2_price * GWP100`
*'
*' Therefore, in the case of GWP100 the marginal emission cost (as derived from 
*' emission cost function) and the initial emission price (im_pollutant_prices) agree.
*' Therefore, no change is needed in case of GWP100.
*'
im_pollutant_prices(t,i,poll_gwp100) = im_pollutant_prices(t,i,poll_gwp100);
*'
*' For GWPstar, the underlying formula, based on @Lynch2020 equation 3, used for 
*' the calculation of emission cost (`poll_gwpstar`) is: 
*'
*' `emis_cost(t) = (4 * emis(t) - 3.75 * emis(t-20)) * CO2_price * GWP100`
*'
*' First derivative (myopic case: emis(t) is a variable; emis(t-20) is a parameter):
*'
*' `marg_emis_cost(t) = 4 * CO2_price * GWP100`
*'
*' Therefore, in the case of GWPstar the marginal emission cost (as derived from 
*' emission cost function) and the initial emission price (im_pollutant_prices) differ 
*' by a factor of 4.
*' Therefore, the initial emission price (im_pollutant_prices) needs to multiplied by factor 4.
*'
im_pollutant_prices(t,i,poll_gwpstar) = 4 * im_pollutant_prices(t,i,poll_gwpstar);
*'
*' This adjustment of `im_pollutant_prices` in the case of GWPstar is of particular 
*' importance for the [57_maccs] module, which needs to see the marginal cost 
*' of one additional unit of emission based on the formulation of emission costs 
*' in [56_ghg_policy].
*' @stop
