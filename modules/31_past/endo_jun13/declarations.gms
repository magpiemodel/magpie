*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q31_prod(j)              Cellular pasture production constraint (mio. tDM per yr)
 q31_carbon(j,ag_pools)   Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)    Costs for putting animals on pastures (mio. USD05MER per yr)
 q31_bv_manpast(j,potnatveg)    Biodiversity value for managed pastures (Mha)
 q31_bv_rangeland(j,potnatveg)    Biodiversity value for rangeland (Mha)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq31_prod(t,j,type)                   Cellular pasture production constraint (mio. tDM per yr)
 oq31_carbon(t,j,ag_pools,type)        Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)         Costs for putting animals on pastures (mio. USD05MER per yr)
 oq31_bv_manpast(t,j,potnatveg,type)   Biodiversity value for managed pastures (Mha)
 oq31_bv_rangeland(t,j,potnatveg,type) Biodiversity value for rangeland (Mha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
