*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon_annuity(j,land) Calculation of cellular annuity costs of landconversion
 q39_cost_landcon(j,land)        Calculation of cellular landconversion costs
;

variables
 vm_cost_landcon(j,land)                    landconversion costs  (mio US$)
;

scalars
s39_min_gdp                                                minimum gdp_pc of all regions in 1995 [US$ per capita]
s39_max_gdp                                                maximum gdp_pc of all regions in 1995 [US$ per capita]
;

parameters
p39_par_a(land)                                        parameter a for landconversion costs calculation
p39_par_b(land)                                        parameter b for landconversion costs calculation
p39_lndcon_type(land)                        for which land types are landconversion costs applicable
p39_lndcon_costs(t,i,land)                land conversion costs [US$ per ha]
pc39_lndcon_costs(i,land)                current land conversion costs [US$ per ha]
p39_cost_landcon_past(t,j,land) costs for landconversion from the past [million US$]
pc39_cost_landcon_past(j,land)  current costs for landconversion from the past [million US$]
;

positive variable
 v39_cost_landcon_annuity(j,land) annuity costs of landconversion in the current timestep (mio. US$)
;
*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)           landconversion costs  (mio US$)
 ov39_cost_landcon_annuity(t,j,land,type) annuity costs of landconversion in the current timestep (mio. US$)
 oq39_cost_landcon_annuity(t,j,land,type) Calculation of cellular annuity costs of landconversion
 oq39_cost_landcon(t,j,land,type)         Calculation of cellular landconversion costs
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
