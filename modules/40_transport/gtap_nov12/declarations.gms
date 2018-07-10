*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equation
q40_cost_transport(j,k)   					Cellular transport costs for k (mio. USD05 per yr)
;

variables
 vm_cost_transp(j,k)                        Transportation costs (mio. USD05 per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_transp(t,j,k,type)      Transportation costs (mio. USD05 per yr)
 oq40_cost_transport(t,j,k,type) Cellular transport costs for k (mio. USD05 per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
