*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon_annuity(j,land)	Calculation of cellular annuity costs of landconversion (mio USD per yr)
 q39_cost_landcon(j,land)        	Calculation of cellular landconversion costs (mio USD per yr)
;

variables
 vm_cost_landcon(j,land)            landconversion costs (mio USD per yr)
;

positive variable
 v39_cost_landcon_annuity(j,land) annuity costs of landconversion in the current timestep (mio USD per yr)
;

scalar
s39_min_gdp                           minimum gdp_pc of all regions in 1995 (USD per capita per yr)
s39_max_gdp                           maximum gdp_pc of all regions in 1995 (USD per capita per yr)
;

parameters
i39_landclear_gdp(bound39)            global range of land clearing costs (USD per ton C)
p39_landclear_a                       intercept for land clearing costs calculation (1)
p39_landclear_b                       slope for land clearing costs calculation (1)
p39_landclear_reg(t,i,land)	  		  regional land clearing costs (USD per ton C)
p39_landclear(t,j,land)         	  cellular land clearing costs (USD per ton C)
pc39_landclear(j,land)          	  current cellular land clearing costs (USD per ton C)

i39_establish_gdp(land,bound39)       global range of land establishment costs (USD per hectare)
p39_establish_a(land)                 intercept for establishment costs calculation (1)
p39_establish_b(land)                 slope for establishment costs calculation (1)
p39_establish_reg(t,i,land)	  		  regional establishment costs (USD per hectare)
p39_establish(t,j,land)         	  cellular establishment costs (USD per hectare)
pc39_establish(j,land)          	  current cellular establishing costs (USD per hectare)

p39_cost_landcon_past(t,j,land)       costs for landconversion from the past (mio USD per yr)
pc39_cost_landcon_past(j,land)        current costs for landconversion from the past (mio USD per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)           landconversion costs (mio USD per yr)
 ov39_cost_landcon_annuity(t,j,land,type) annuity costs of landconversion in the current timestep (mio USD per yr)
 oq39_cost_landcon_annuity(t,j,land,type) Calculation of cellular annuity costs of landconversion (mio USD per yr)
 oq39_cost_landcon(t,j,land,type)         Calculation of cellular landconversion costs (mio USD per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
