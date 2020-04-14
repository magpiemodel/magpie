*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q39_cost_landcon_annuity(j,land)	Calculation of cellular annuity costs of landconversion (mio. USD05MER per yr)
 q39_cost_landcon(j,land)        	Calculation of cellular landconversion costs (mio. USD05MER per yr)
;

variables
 vm_cost_landcon(j,land)            Land conversion costs (mio. USD05MER per yr)
;

positive variable
 v39_cost_landcon_annuity(j,land) Annuity costs of landconversion in the current timestep (mio. USD05MER per yr)
;

scalar
 s39_cost_establish                    Global land establishment costs (USD05MER per hectare)
 s39_cost_clearing                     Global land clearing costs (USD05MER per ton C)
;

parameters
 i39_cost_establish(land)			   Global land establishment costs (USD05MER per hectare)
 i39_cost_clearing(land)               Global land clearing costs (USD05MER per ton C)
 p39_cost_landcon_past(t,j,land)       Costs for landconversion from the past (mio. USD05MER per yr)
 pc39_cost_landcon_past(j,land)        Costs for landconversion from the past in the current time step (mio. USD05MER per yr)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landcon(t,j,land,type)           Land conversion costs (mio. USD05MER per yr)
 ov39_cost_landcon_annuity(t,j,land,type) Annuity costs of landconversion in the current timestep (mio. USD05MER per yr)
 oq39_cost_landcon_annuity(t,j,land,type) Calculation of cellular annuity costs of landconversion (mio. USD05MER per yr)
 oq39_cost_landcon(t,j,land,type)         Calculation of cellular landconversion costs (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
