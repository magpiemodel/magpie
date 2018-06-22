*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_pollutant_prices(t_all,i,pollutants)      certificate prices for N2O-N CH4 CO2-C (US$2004 per Mg)
 p56_ghg_price_growth_rate(t,i,pollutants)    growth rate of certificate price 
 p56_ghg_price_growth_rate_avg(i,pollutants)  average over time of growth rate of certificate price
;

equations
 q56_technical_mitigation_reg(i,pollutants,emis_source)   application of maccs on emissions
 q56_technical_mitigation_cell(j,pollutants,emis_source)  application of maccs on emissions
 q56_cell_to_reg(i,pollutants,emis_source)                aggregation to regional emissions
 q56_emission_costs(i)                                    calculation of total emission costs
 q56_emission_costs_reg_yearly(i,emis_reg_yearly56)       calculation of regional costs for annual emissions
 q56_emission_costs_reg_oneoff(i,emis_reg_oneoff56)       calculation of regional costs for emissions occuring only once in time
 q56_emission_costs_cell_yearly(j,emis_cell_yearly56)     calculation of cellular costs for annual emissions
 q56_emission_costs_cell_oneoff(j,emis_cell_oneoff56)     calculation of cellular costs for emissions occuring only once in time
 q56_reward_cdr_aff_reg(i)                                regional revenues for carbon captured by afforestation
 q56_reward_cdr_aff(j,co2_forestry)                       cellular revenues for carbon captured by afforestation
;

positive variables
 v56_reward_cdr_aff(j,co2_forestry)  regional revenues for carbon captured by afforestation (10^6 US$ per yr)
 vm_reward_cdr_aff(i)                cellular revenues for carbon captured by afforestation (10^6 US$ per yr)
;

variables
 vm_btm_reg(i,emis_source,pollutants)                        regional N2O-N CH4 CO2-C emissions before technical mitigation [58_carbon_removal] (Tg per yr)
 vm_btm_cell(j,emis_source,pollutants)                       cellular N2O-N CH4 CO2-C emissions before technical mitigation [58_carbon_removal] (Tg per yr)
 vm_emission_costs(i)                                        Costs for emission rights for pollutants and greenhouse gases (10^6 US$ per yr)
 vm_emissions_reg(i,emis_source,pollutants)                  regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 v56_emis_cell(j,emis_source,pollutants)                     cellular emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 v56_emission_costs_reg_yearly(i,emis_reg_yearly56)          costs for emissions occuring yearly (10^6 US$ per yr)
 v56_emission_costs_reg_oneoff(i,emis_reg_oneoff56)          costs for emissions occuring only once in time (10^6 US$ per yr)
 v56_emission_costs_cell_yearly(j,emis_cell_yearly56)        costs for emissions occuring yearly (10^6 US$ per yr)
 v56_emission_costs_cell_oneoff(j,emis_cell_oneoff56)        costs for emissions occuring only once in time (10^6 US$ per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov56_reward_cdr_aff(t,j,co2_forestry,type)                      regional revenues for carbon captured by afforestation (10^6 US$ per yr)
 ov_reward_cdr_aff(t,i,type)                                     cellular revenues for carbon captured by afforestation (10^6 US$ per yr)
 ov_btm_reg(t,i,emis_source,pollutants,type)                     regional N2O-N CH4 CO2-C emissions before technical mitigation [58_carbon_removal] (Tg per yr)
 ov_btm_cell(t,j,emis_source,pollutants,type)                    cellular N2O-N CH4 CO2-C emissions before technical mitigation [58_carbon_removal] (Tg per yr)
 ov_emission_costs(t,i,type)                                     Costs for emission rights for pollutants and greenhouse gases (10^6 US$ per yr)
 ov_emissions_reg(t,i,emis_source,pollutants,type)               regional emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 ov56_emis_cell(t,j,emis_source,pollutants,type)                 cellular emissions by source and gas after technical mitigation N CH4 C (Tg per yr)
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yearly56,type)      costs for emissions occuring yearly (10^6 US$ per yr)
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_oneoff56,type)      costs for emissions occuring only once in time (10^6 US$ per yr)
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yearly56,type)    costs for emissions occuring yearly (10^6 US$ per yr)
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_oneoff56,type)    costs for emissions occuring only once in time (10^6 US$ per yr)
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,type)  application of maccs on emissions
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,type) application of maccs on emissions
 oq56_cell_to_reg(t,i,pollutants,emis_source,type)               aggregation to regional emissions
 oq56_emission_costs(t,i,type)                                   calculation of total emission costs
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yearly56,type)      calculation of regional costs for annual emissions
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_oneoff56,type)      calculation of regional costs for emissions occuring only once in time
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yearly56,type)    calculation of cellular costs for annual emissions
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_oneoff56,type)    calculation of cellular costs for emissions occuring only once in time
 oq56_reward_cdr_aff_reg(t,i,type)                               regional revenues for carbon captured by afforestation
 oq56_reward_cdr_aff(t,j,co2_forestry,type)                      cellular revenues for carbon captured by afforestation
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
