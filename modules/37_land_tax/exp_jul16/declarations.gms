*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

equations
 q37_cost_landtax_annuity(j,land_ag) Calculation of cellular annuity costs of land taxation
 q37_cost_landtax(j,land_ag)        Calculation of cellular land taxation costs
;

variables
 vm_cost_landtax(j,land_ag)     land taxation costs  (mio US$)
;

parameters
 p37_cost_landtax_past(t,j,land_ag) costs from land taxation from the past [million US$]
;

positive variable
 v37_cost_landtax_annuity(j,land_ag) annuity costs of landtaxversion in the current timestep (mio. US$)
;
*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_landtax(t,j,land_ag,type)           land taxation costs  (mio US$)
 ov37_cost_landtax_annuity(t,j,land_ag,type) annuity costs of landtaxversion in the current timestep (mio. US$)
 oq37_cost_landtax_annuity(t,j,land_ag,type) Calculation of cellular annuity costs of land taxation
 oq37_cost_landtax(t,j,land_ag,type)         Calculation of cellular land taxation costs
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
