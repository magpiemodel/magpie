*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equation
q40_cost_transport(j,k)   Cellular transport costs for k (mio. USD05MER per yr)
;

variables
 vm_cost_transp(j,k)      Transportation costs (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_transp(t,j,k,type)      Transportation costs (mio. USD05MER per yr)
 oq40_cost_transport(t,j,k,type) Cellular transport costs for k (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
