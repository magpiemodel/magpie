*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon_annuity(j,land)	Calculation of cellular annuity costs of landconversion
 q39_cost_landcon(j,land)        	Calculation of cellular landconversion costs
;

variables
 vm_cost_landcon(j,land)            landconversion costs  (mio US$)
;

positive variable
 v39_cost_landcon_annuity(j,land) annuity costs of landconversion in the current timestep (mio. US$)
;

scalar
s39_min_gdp                           minimum gdp_pc of all regions in 1995 (US$ per capita)
s39_max_gdp                           maximum gdp_pc of all regions in 1995 (US$ per capita)
;

parameters
i39_landclear_gdp(bound39)            global range of land clearing costs (US$ per hectare)
p39_landclear_a                       intercept for land clearing costs calculation
p39_landclear_b                       slope for land clearing costs calculation
p39_landclear_costs_reg(t,i,land)	  regional land clearing costs (US$ per hectare)
p39_landclear_costs(t,j,land)         cellular land clearing costs (US$ per hectare)
pc39_landclear_costs(j,land)          current cellular land clearing costs (US$ per hectare)

i39_establish_gdp(land,bound39)       global range of land establishment costs (US$ per hectare)
p39_establish_a(land)                 intercept for establishment costs calculation
p39_establish_b(land)                 slope for establishment costs calculation
p39_establish_costs_reg(t,i,land)	  regional establishment costs (US$ per hectare)
p39_establish_costs(t,j,land)         cellular establishment costs (US$ per hectare)
pc39_establish_costs(j,land)          current cellular establishing costs (US$ per hectare)

p39_carbon_density(t,j,land,c_pools)	  actual vegetation carbon density in natveg (tC per ha)
p39_max_vegc_reg(t,i)					  maximum regional vegetation carbon density (tC per ha)
p39_vegc_fact(t,j,land)                	  scaling factor that reduces clearing costs depending on vegetation density (-)

p39_cost_landcon_past(t,j,land)       costs for landconversion from the past (mio US$)
pc39_cost_landcon_past(j,land)        current costs for landconversion from the past (mio US$)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)           landconversion costs  (mio US$)
 ov39_cost_landcon_annuity(t,j,land,type) annuity costs of landconversion in the current timestep (mio. US$)
 oq39_cost_landcon_annuity(t,j,land,type) Calculation of cellular annuity costs of landconversion
 oq39_cost_landcon(t,j,land,type)         Calculation of cellular landconversion costs
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
