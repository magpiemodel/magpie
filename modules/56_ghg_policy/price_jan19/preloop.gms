*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


****select ghg prices
$ifthen "%c56_pollutant_prices%" == "coupling" im_pollutant_prices(t,i,pollutants) = f56_pollutant_prices_coupling(t,i,pollutants);
$elseif "%c56_pollutant_prices%" == "emulator" im_pollutant_prices(t,i,pollutants) = f56_pollutant_prices_emulator(t,pollutants);
$else im_pollutant_prices(t,i,pollutants) = f56_pollutant_prices(t,i,pollutants,"%c56_pollutant_prices%");
$endif

***limit CH4 and N2O GHG prices based on s56_limit_ch4_n2o_price
*12/44 conversion from USD per tC to USD per tCO2
*28 and 265 Global Warming Potentials from AR5 WG1 CH08 Table 8.7, conversion from USD per tCO2 to USD per tCH4 and USD per tN2O
*44/28 conversion from USD per tN2O to USD per tN
im_pollutant_prices(t,i,"ch4")$(im_pollutant_prices(t,i,"ch4") > s56_limit_ch4_n2o_price*12/44*28) = s56_limit_ch4_n2o_price*12/44*28;
im_pollutant_prices(t,i,"n2o_n_direct")$(im_pollutant_prices(t,i,"n2o_n_direct") > s56_limit_ch4_n2o_price*12/44*265*44/28) = s56_limit_ch4_n2o_price*12/44*265*44/28;
im_pollutant_prices(t,i,"n2o_n_indirect")$(im_pollutant_prices(t,i,"n2o_n_indirect") > s56_limit_ch4_n2o_price*12/44*265*44/28) = s56_limit_ch4_n2o_price*12/44*265*44/28;

***apply reduction factor on CO2 price to account for potential negative side effects
***lowers the economic incentive for CO2 emission reduction (avoided deforestation) and afforestation
im_pollutant_prices(t,i,"co2_c") = im_pollutant_prices(t,i,"co2_c")*s56_cprice_red_factor;

***phase-in of GHG price over 20 year period; start depends on s56_ghgprice_start
im_pollutant_prices(t,i,pollutants)$(m_year(t) < s56_ghgprice_start) = 0;
im_pollutant_prices(t,i,pollutants)$(m_year(t) = s56_ghgprice_start) = 0.1*im_pollutant_prices(t,i,pollutants);
im_pollutant_prices(t,i,pollutants)$(m_year(t) = s56_ghgprice_start+5) = 0.2*im_pollutant_prices(t,i,pollutants);
im_pollutant_prices(t,i,pollutants)$(m_year(t) = s56_ghgprice_start+10) = 0.4*im_pollutant_prices(t,i,pollutants);
im_pollutant_prices(t,i,pollutants)$(m_year(t) = s56_ghgprice_start+15) = 0.8*im_pollutant_prices(t,i,pollutants);
im_pollutant_prices(t,i,pollutants)$(m_year(t) >= s56_ghgprice_start+20) = im_pollutant_prices(t,i,pollutants);

***multiply GHG prices with development state to account for institutional requirements needed for implementing a GHG pricing scheme
im_pollutant_prices(t,i,pollutants) = im_pollutant_prices(t,i,pollutants)*im_development_state(t,i);

display im_pollutant_prices;

***GHG emission policy
p56_emis_policy(t,i,pollutants,emis_source) = f56_emis_policy("%c56_emis_policy%",pollutants,emis_source);

*reward neg emissions depending on s56_reward_neg_emis
v56_emission_costs_cell_oneoff.lo(j2,emis_cell_one56) = s56_reward_neg_emis;

*calculate ghg price growth rate
*http://de.wikihow.com/Berechnung-einer-Wachstumsrate#/Bild:Calculate-Growth-Rate-Step-6.jpg
p56_ghg_price_growth_rate(t,i,pollutants) = 0;
p56_ghg_price_growth_rate(t,i,pollutants)$(ord(t)>1 AND im_pollutant_prices(t-1,i,pollutants) > 0) = (im_pollutant_prices(t,i,pollutants)/im_pollutant_prices(t-1,i,pollutants))**(1/m_yeardiff(t))-1;
*remove negative values
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) <= 0) = 0;
*remove values exceeding 10%
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) > 0.1) = 0.1;
*calculate average growth rate over time
p56_ghg_price_growth_rate_avg(i,pollutants) = sum(t, p56_ghg_price_growth_rate(t,i,pollutants))/card(t);
*limit deviation from average growth rate over time to 1%
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) > p56_ghg_price_growth_rate_avg(i,pollutants)+0.01) = p56_ghg_price_growth_rate_avg(i,pollutants)+0.01;
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) < p56_ghg_price_growth_rate_avg(i,pollutants)-0.01) = p56_ghg_price_growth_rate_avg(i,pollutants)-0.01;
*account for special case if average growth rate is very low (<= 1%)
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) = 0) = p56_ghg_price_growth_rate_avg(i,pollutants);
*if average growth rate is zero use 5% as default
p56_ghg_price_growth_rate(t,i,pollutants)$(p56_ghg_price_growth_rate(t,i,pollutants) = 0) = 0.05;
