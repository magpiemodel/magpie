*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 im_pollutant_prices(t_all,i,pollutants)  ghg or pollution certificate prices (US$ 2004 per Mg N2O-N CH4 and CO2-C)
 p56_ghg_price_growth_rate(t,i,pollutants)  ghg certificate price growth rate
 p56_ghg_price_growth_rate_avg(i,pollutants)  ghg certificate price growth rate average over time
;

equations
 q56_technical_mitigation_reg(i,pollutants,emis_source)  application of maccs on emission sources
 q56_technical_mitigation_cell(j,pollutants,emis_source)  application of maccs on emission sources
 q56_cell_to_reg(i,pollutants,emis_source)      aggregation to regional emissions
 q56_emission_costs(i)  calculation of total costs for pollution rights
 q56_emission_costs_reg_yearly(i,emis_reg_yearly56) calculation of costs pollution rights from emissions occuring yearly
 q56_emission_costs_reg_oneoff(i,emis_reg_oneoff56) calculation of costs pollution rights occuring only once in time
 q56_emission_costs_cell_yearly(j,emis_cell_yearly56) calculation of costs pollution rights from emissions occuring yearly
 q56_emission_costs_cell_oneoff(j,emis_cell_oneoff56) calculation of costs pollution rights occuring only once in time
 q56_reward_cdr_aff_reg(i) reward for CDR from afforestation
 q56_reward_cdr_aff(j,emis_source_co2_forestry) reward for CDR from afforestation
;

positive variables
 v56_reward_cdr_aff(j,emis_source_co2_forestry)  reward for CDR from afforestation (mio. US$)
 vm_reward_cdr_aff(i)                            reward for CDR from afforestation (mio. US$)
;

variables
 vm_btm_reg(i,emis_source,pollutants)          see description of [58_carbon_removal] (Tg N2O - Tg CH4 - Tg CO2)
 vm_btm_cell(j,emis_source,pollutants)     see description of [58_carbon_removal] (Tg N2O - Tg CH4 - Tg CO2)
 vm_emission_costs(i)                       Costs for emission pollution rights (mio. US$)
 vm_emissions_reg(i,emis_source,pollutants)           regional emissions by emission source after technical mitigation (Tg N2O-N CH4 C)
 v56_emis_cell(j,emis_source,pollutants)                       cellular emissions by emission source after technical mitigation (Tg N CH4 C)
 v56_emission_costs_reg_yearly(i,emis_reg_yearly56)          costs for pollution (mio. US$) from emissions occuring yearly
 v56_emission_costs_reg_oneoff(i,emis_reg_oneoff56)          costs for pollution (mio. US$) from emissions occuring only once in time
 v56_emission_costs_cell_yearly(j,emis_cell_yearly56)          costs for pollution (mio. US$) from emissions occuring yearly
 v56_emission_costs_cell_oneoff(j,emis_cell_oneoff56)          costs for pollution (mio. US$) from emissions occuring only once in time
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov56_reward_cdr_aff(t,j,emis_source_co2_forestry,type)          reward for CDR from afforestation (mio. US$)
 ov_reward_cdr_aff(t,i,type)                                     reward for CDR from afforestation (mio. US$)
 ov_btm_reg(t,i,emis_source,pollutants,type)                     emissions before technical mitigation (Tg N2O-N CH4 and CO2-C)
 ov_btm_cell(t,j,emis_source,pollutants,type)                    emissions before technical mitigation (Tg N2O-N CH4 and CO2-C)
 ov_emission_costs(t,i,type)                                     Costs for emission pollution rights (mio. US$)
 ov_emissions_reg(t,i,emis_source,pollutants,type)               regional emissions by emission source after technical mitigation (Tg N2O-N CH4 C)
 ov56_emis_cell(t,j,emis_source,pollutants,type)                 cellular emissions by emission source after technical mitigation (Tg N CH4 C)
 ov56_emission_costs_reg_yearly(t,i,emis_reg_yearly56,type)      costs for pollution (mio. US$) from emissions occuring yearly
 ov56_emission_costs_reg_oneoff(t,i,emis_reg_oneoff56,type)      costs for pollution (mio. US$) from emissions occuring only once in time
 ov56_emission_costs_cell_yearly(t,j,emis_cell_yearly56,type)    costs for pollution (mio. US$) from emissions occuring yearly
 ov56_emission_costs_cell_oneoff(t,j,emis_cell_oneoff56,type)    costs for pollution (mio. US$) from emissions occuring only once in time
 oq56_technical_mitigation_reg(t,i,pollutants,emis_source,type)  application of maccs on emission sources
 oq56_technical_mitigation_cell(t,j,pollutants,emis_source,type) application of maccs on emission sources
 oq56_cell_to_reg(t,i,pollutants,emis_source,type)               aggregation to regional emissions
 oq56_emission_costs(t,i,type)                                   calculation of total costs for pollution rights
 oq56_emission_costs_reg_yearly(t,i,emis_reg_yearly56,type)      calculation of costs pollution rights from emissions occuring yearly
 oq56_emission_costs_reg_oneoff(t,i,emis_reg_oneoff56,type)      calculation of costs pollution rights occuring only once in time
 oq56_emission_costs_cell_yearly(t,j,emis_cell_yearly56,type)    calculation of costs pollution rights from emissions occuring yearly
 oq56_emission_costs_cell_oneoff(t,j,emis_cell_oneoff56,type)    calculation of costs pollution rights occuring only once in time
 oq56_reward_cdr_aff_reg(t,i,type)                               reward for CDR from afforestation
 oq56_reward_cdr_aff(t,j,emis_source_co2_forestry,type)          reward for CDR from afforestation
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
