*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* starting value of above ground carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful
vm_carbon_stock.l(j,land,ag_pools,stockType) = fm_carbon_density("y1995",j,land,ag_pools)*pcm_land(j,land);

v56_emis_pricing.fx(i,emis_oneoff,pollutants)$(not sameas(pollutants,"co2_c")) = 0;

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
 im_pollutant_prices(t_all,i,pollutants,emis_source) = f56_pollutant_prices_coupling(t_all,i,pollutants);
$elseif "%c56_pollutant_prices%" == "emulator"
 im_pollutant_prices(t_all,i,pollutants,emis_source) = f56_pollutant_prices_emulator(t_all,i,pollutants);
$else
 im_pollutant_prices(t_all,i,pollutants,emis_source) = f56_pollutant_prices(t_all,i,pollutants,"%c56_pollutant_prices%") * p56_region_price_shr(t_all,i)
 																				 + f56_pollutant_prices(t_all,i,pollutants,"%c56_pollutant_prices_noselect%") * (1-p56_region_price_shr(t_all,i));
** Harmonize till 2020 if not coupled or emulator
loop(t_all$(m_year(t_all) <= sm_fix_SSP2),
im_pollutant_prices(t_all,i,pollutants,emis_source) = f56_pollutant_prices(t_all,i,pollutants,"R21M42-SSP2-NPi") * p56_region_price_shr(t_all,i)
                                        + f56_pollutant_prices(t_all,i,pollutants,"R21M42-SSP2-NPi") * (1-p56_region_price_shr(t_all,i));
);
$endif


***save im_pollutant_prices to parameter
p56_pollutant_prices_input(t_all,i,pollutants,emis_source) = im_pollutant_prices(t_all,i,pollutants,emis_source);

***limit CH4 and N2O GHG prices based on s56_limit_ch4_n2o_price
*12/44 conversion from USD per tC to USD per tCO2
*28 and 265 Global Warming Potentials from AR5 WG1 CH08 Table 8.7, conversion from USD per tCO2 to USD per tCH4 and USD per tN2O
*44/28 conversion from USD per tN2O to USD per tN
im_pollutant_prices(t_all,i,"ch4",emis_source)$(im_pollutant_prices(t_all,i,"ch4",emis_source) > s56_limit_ch4_n2o_price*12/44*28) = s56_limit_ch4_n2o_price*12/44*28;
im_pollutant_prices(t_all,i,"n2o_n_direct",emis_source)$(im_pollutant_prices(t_all,i,"n2o_n_direct",emis_source) > s56_limit_ch4_n2o_price*12/44*265*44/28) = s56_limit_ch4_n2o_price*12/44*265*44/28;
im_pollutant_prices(t_all,i,"n2o_n_indirect",emis_source)$(im_pollutant_prices(t_all,i,"n2o_n_indirect",emis_source) > s56_limit_ch4_n2o_price*12/44*265*44/28) = s56_limit_ch4_n2o_price*12/44*265*44/28;

***apply reduction factor on CO2 price to account for potential negative side effects
***lowers the economic incentive for CO2 emission reduction (avoided deforestation) and afforestation
im_pollutant_prices(t_all,i,"co2_c",emis_source) = im_pollutant_prices(t_all,i,"co2_c",emis_source)*s56_cprice_red_factor;

***phase-in of GHG price over 20 year period; start depends on s56_ghgprice_start
if (s56_ghgprice_phase_in = 1,
im_pollutant_prices(t_all,i,pollutants,emis_source)$(m_year(t_all) < s56_ghgprice_start) = 0;
im_pollutant_prices(t_all,i,pollutants,emis_source)$(m_year(t_all) = s56_ghgprice_start) = 0.1*im_pollutant_prices(t_all,i,pollutants,emis_source);
im_pollutant_prices(t_all,i,pollutants,emis_source)$(m_year(t_all) = s56_ghgprice_start+5) = 0.2*im_pollutant_prices(t_all,i,pollutants,emis_source);
im_pollutant_prices(t_all,i,pollutants,emis_source)$(m_year(t_all) = s56_ghgprice_start+10) = 0.4*im_pollutant_prices(t_all,i,pollutants,emis_source);
im_pollutant_prices(t_all,i,pollutants,emis_source)$(m_year(t_all) = s56_ghgprice_start+15) = 0.8*im_pollutant_prices(t_all,i,pollutants,emis_source);
im_pollutant_prices(t_all,i,pollutants,emis_source)$(m_year(t_all) >= s56_ghgprice_start+20) = im_pollutant_prices(t_all,i,pollutants,emis_source);
);
***multiply GHG prices with development state to account for institutional requirements needed for implementing a GHG pricing scheme
im_pollutant_prices(t_all,i,pollutants,emis_source)$(s56_ghgprice_devstate_scaling = 1) = im_pollutant_prices(t_all,i,pollutants,emis_source)*im_development_state(t_all,i);

***GHG emission policy
im_pollutant_prices(t_all,i,pollutants,emis_source) = im_pollutant_prices(t_all,i,pollutants,emis_source) * f56_emis_policy("%c56_emis_policy%",pollutants,emis_source);

***construct age-class dependent C price for afforestation incentive
***this is needed because time steps (t) and age-classes (ac) can differ. ac and t_all are always in 5-year time steps.
*For missing years in t_all use C price of previous time step. This step makes sure that C prices for every 5-year time step are available.
loop(t_all$(m_year(t_all)>=s56_ghgprice_start),
	im_pollutant_prices(t_all,i,"co2_c",emis_source)$(im_pollutant_prices(t_all,i,"co2_c",emis_source) = 0) = im_pollutant_prices(t_all-1,i,"co2_c",emis_source);
);
*Linear interpolation of C price for missing time steps
loop(t,
 s56_timesteps = m_yeardiff(t)/5;
  if (s56_timesteps > 1,
   s56_counter = 0;
    repeat(
       s56_counter = s56_counter + 1;
       s56_offset = s56_timesteps-s56_counter;
       im_pollutant_prices(t_all-s56_offset,i,"co2_c",emis_source)$(m_year(t_all) = m_year(t)) =
       im_pollutant_prices(t-1,i,"co2_c",emis_source) +
       (im_pollutant_prices(t,i,"co2_c",emis_source) - im_pollutant_prices(t-1,i,"co2_c",emis_source))*s56_counter/(s56_timesteps);
    until s56_counter = s56_timesteps-1);
  );
);

*initialize age-class dependent C price with same C price for all age-classes
p56_c_price_aff(t_all,i,ac) = im_pollutant_prices(t_all,i,"co2_c","forestry_vegc");
*Shift C prices in age-classes for reflecting foresight.
*e.g. ac5 in 2020 should have the C price of ac0 in 2025, and ac20 in 2020 equals to ac0 in 2040
p56_c_price_aff(t_all,i,ac)$(ord(t_all)+ac.off<card(t_all)) = p56_c_price_aff(t_all+ac.off,i,"ac0");
*limit foresight of C prices to X years; constant C price after X years.
ac_exp(ac)$(ac.off = s56_c_price_exp_aff/5) = yes;
p56_c_price_aff(t_all,i,ac)$(ac.off >= s56_c_price_exp_aff/5) = sum(ac_exp, p56_c_price_aff(t_all,i,ac_exp));
*zero C price before starting year
p56_c_price_aff(t_all,i,ac)$(m_year(t_all)<s56_ghgprice_start) = 0;
