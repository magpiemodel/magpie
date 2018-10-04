*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


****select ghg prices
$ifthen "%c56_pollutant_prices%" == "coupling" im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices_coupling(t_all,i,pollutants);
$elseif "%c56_pollutant_prices%" == "emulator" im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices_emulator(t_all,pollutants);
$else im_pollutant_prices(t_all,i,pollutants) = f56_pollutant_prices(t_all,i,pollutants,"%c56_pollutant_prices%");
$endif

***limit CH4 and N2O GHG prices based on s56_limit_ch4_n2o_price
*12/44 conversion from USD per tC to USD per tCO2
*25 and 298 GWP factors for CH4 and N2O respectively, conversion from USD per tCO2 to USD per tCH4 and USD per tN2O
*44/28 conversion from USD per tN2O to USD per tN
im_pollutant_prices(t_all,i,"ch4")$(im_pollutant_prices(t_all,i,"ch4") > s56_limit_ch4_n2o_price*12/44*25) = s56_limit_ch4_n2o_price*12/44*25;
im_pollutant_prices(t_all,i,"n2o_n_direct")$(im_pollutant_prices(t_all,i,"n2o_n_direct") > s56_limit_ch4_n2o_price*12/44*298*44/28) = s56_limit_ch4_n2o_price*12/44*298*44/28;
im_pollutant_prices(t_all,i,"n2o_n_indirect")$(im_pollutant_prices(t_all,i,"n2o_n_indirect") > s56_limit_ch4_n2o_price*12/44*298*44/28) = s56_limit_ch4_n2o_price*12/44*298*44/28;

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
