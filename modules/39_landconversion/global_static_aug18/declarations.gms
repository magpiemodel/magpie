*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon_annuity(j,land)	Calculation of cellular annuity costs of landconversion (mio. USD05MER per yr)
 q39_cost_landcon(j,land)        	Calculation of cellular landconversion costs (mio. USD05MER per yr)
;

variables
 vm_cost_landcon(j,land)            landconversion costs (mio. USD05MER per yr)
;

positive variable
 v39_cost_landcon_annuity(j,land) annuity costs of landconversion in the current timestep (mio. USD05MER per yr)
;

scalar
 s39_cost_establish                    global land establishment costs (USD05MER per hectare)
 s39_cost_clearing                     global land clearing costs (USD05MER per ton C)
;

parameters
 i39_cost_establish(land)			   global land establishment costs (USD05MER per hectare)
 i39_cost_clearing(land)               global land clearing costs (USD05MER per ton C)
 p39_cost_landcon_past(t,j,land)       costs for landconversion from the past (mio. USD05MER per yr)
 pc39_cost_landcon_past(j,land)        current costs for landconversion from the past (mio. USD05MER per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)           landconversion costs (mio. USD05MER per yr)
 ov39_cost_landcon_annuity(t,j,land,type) annuity costs of landconversion in the current timestep (mio. USD05MER per yr)
 oq39_cost_landcon_annuity(t,j,land,type) Calculation of cellular annuity costs of landconversion (mio. USD05MER per yr)
 oq39_cost_landcon(t,j,land,type)         Calculation of cellular landconversion costs (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
