*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
* q39_cost_establish_annuity(j,land) Calculation of cellular annuity costs of land-use establishment
* q39_cost_landclear_annuity(j,land) Calculation of cellular annuity costs of land clearing
 q39_cost_landcon_annuity(j,land) Calculation of cellular annuity costs of landconversion
 q39_cost_landcon(j,land)        Calculation of cellular landconversion costs
;

variables
 vm_cost_landcon(j,land)                    landconversion costs  (mio US$)
;

positive variable
* v39_cost_establish_annuity(j,land) annuity costs of land-use establishment in the current timestep (mio. US$)
* v39_cost_landclear_annuity(j,land) annuity costs of land clearing in the current timestep
 v39_cost_landcon_annuity(j,land) annuity costs of landconversion in the current timestep (mio. US$)
;

scalar
s39_min_gdp                           minimum gdp_pc of all regions in 1995 [US$ per capita]
s39_max_gdp                           maximum gdp_pc of all regions in 1995 [US$ per capita]
;

parameters
p39_max_carbon_reg(i)                 maximum vegetation carbon density per region
p39_max_carbon_glo                    maximum vegetation carbon density globally
p39_landclear_a                       parameter a for land clearing costs calculation
i39_landclear_gdp(bound39)            cost estimates for land clearing costs
p39_landclear_b                       parameter b for land clearing costs calculation
i39_establish_gdp(land,bound39)       cost estimates for land clearing costs
p39_establish_a(land)                 parameter a for establishing costs calculation
p39_establish_b(land)                 parameter b for establishing costs calculation
pc39_vegc_fact(j,land)                factor that reduces costs depending on vegetation density
p39_establish_costs(t,i,land)         establishing costs [US$ per ha]
pc39_establish_costs(i,land)          current establishing costs [US$ per ha]
p39_landclear_costs(t,j,land)         land clearing costs
pc39_landclear_costs(j,land)          current land clearing costs
p39_cost_landcon_past(t,j,land)       costs for landconversion from the past [million US$]
pc39_cost_landcon_past(j,land)        current costs for landconversion from the past [million US$]
pc39_carbon_density(j,land,c_pools)	  current carbon density
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)           landconversion costs  (mio US$)
 ov39_cost_landcon_annuity(t,j,land,type) annuity costs of landconversion in the current timestep (mio. US$)
 oq39_cost_landcon_annuity(t,j,land,type) Calculation of cellular annuity costs of landconversion
 oq39_cost_landcon(t,j,land,type)         Calculation of cellular landconversion costs
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
