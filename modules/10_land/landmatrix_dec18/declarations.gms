*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_land_start(j,land)         Land initialization area (mio. ha)
 pm_land_hist(t_ini10,j,land)  Land area for historial time steps (mio. ha)
 pcm_land(j,land)              Land area in previous time step including possible changes after optimization (mio. ha)
;

variables
 vm_landdiff                   Aggregated difference in land between current and previous time step (mio. ha)
;

positive variables
 vm_land(j,land)                             Land area of the different land types (mio. ha)
 vm_landexpansion(j,land)                    Land expansion (mio. ha)
 vm_landreduction(j,land)                   Land reduction (mio. ha)
 vm_cost_land_transition(j)                  Costs for lu transitions (mio. USD05MER per yr)
 vm_lu_transitions(j,land_from,land_to) Land transitions between time steps (mio. ha)
 v10_balance_positive(j)          Balance variable for land transitions (mio. ha)
 v10_balance_negative(j)          Balance variable for land transitions (mio. ha)
;

equations
 q10_transition_matrix(j)             Land transition constraint cell area (mio. ha)
 q10_transition_to(j,land_to)       Land transition constraint to (mio. ha)
 q10_transition_from(j,land_from)   Land transition constraint from (mio. ha)
 q10_landexpansion(j,land_to)       Land expansion constraint (mio. ha)
 q10_landreduction(j,land_from)     Land reduction constraint (mio. ha)
 q10_cost(j)                          Costs for lu transitions (mio. USD05MER per yr)
 q10_landdiff                         Land difference constraint (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff(t,type)                           Aggregated difference in land between current and previous time step (mio. ha)
 ov_land(t,j,land,type)                        Land area of the different land types (mio. ha)
 ov_landexpansion(t,j,land,type)               Land expansion (mio. ha)
 ov_landreduction(t,j,land,type)               Land reduction (mio. ha)
 ov_cost_land_transition(t,j,type)             Costs for lu transitions (mio. USD05MER per yr)
 ov_lu_transitions(t,j,land_from,land_to,type) Land transitions between time steps (mio. ha)
 ov10_balance_positive(t,j,type)               Balance variable for land transitions (mio. ha)
 ov10_balance_negative(t,j,type)               Balance variable for land transitions (mio. ha)
 oq10_transition_matrix(t,j,type)              Land transition constraint cell area (mio. ha)
 oq10_transition_to(t,j,land_to,type)          Land transition constraint to (mio. ha)
 oq10_transition_from(t,j,land_from,type)      Land transition constraint from (mio. ha)
 oq10_landexpansion(t,j,land_to,type)          Land expansion constraint (mio. ha)
 oq10_landreduction(t,j,land_from,type)        Land reduction constraint (mio. ha)
 oq10_cost(t,j,type)                           Costs for lu transitions (mio. USD05MER per yr)
 oq10_landdiff(t,type)                         Land difference constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
