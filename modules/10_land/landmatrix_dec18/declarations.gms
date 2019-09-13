*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_land_start(j,land)         Land initialization area (mio. ha)
 pcm_land(j,land)              Land area in previous time step (mio. ha)
;

variables
 vm_landdiff                   Aggregated difference in land between current and previous time step (mio. ha)
;

positive variables
 vm_land(j,land)                             Land area of the different land types (mio. ha)
 vm_landexpansion(j,land)                    Land expansion (mio. ha)
 v10_landreduction(j,land)                   Land reduction (mio. ha)
 vm_croplandexpansion(j,land)                Sources of cropland expansion (mio. ha)
 vm_croplandreduction(j,land)                Targets of cropland reduction (mio. ha)
 vm_cost_land_transition(j)		               Costs for lu transitions (mio. USD05MER per yr)
 v10_lu_transitions(j,land_from10,land_to10) Land transitions between time steps (mio. ha)
;

equations
 q10_land(j)                        	Land conversion constraint (mio. ha)
 q10_transition_matrix(j)			        Land transition constraint cell area (mio. ha)
 q10_transition_to(j,land_to10)		    Land transition constraint to (mio. ha)
 q10_transition_from(j,land_from10)	  Land transition constraint from (mio. ha)
 q10_landexpansion(j,land_to10)       Land expansion constraint (mio. ha)
 q10_landreduction(j,land_from10)     Land reduction constraint (mio. ha)
 q10_croplandreduction(j,land_to10)   Cropland reduction constraint (mio. ha)
 q10_croplandexpansion(j,land_from10) Cropland expansion constraint (mio. ha)
 q10_cost(j)                    	    Costs for lu transitions (mio. USD05MER per yr)
 q10_landdiff                        	Land difference constraint (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff(t,type)                                 Aggregated difference in land between current and previous time step (mio. ha)
 ov_land(t,j,land,type)                              Land area of the different land types (mio. ha)
 ov_landexpansion(t,j,land,type)                     Land expansion (mio. ha)
 ov10_landreduction(t,j,land,type)                   Land reduction (mio. ha)
 ov_croplandexpansion(t,j,land,type)                 Sources of cropland expansion (mio. ha)
 ov_croplandreduction(t,j,land,type)                 Targets of cropland reduction (mio. ha)
 ov_cost_land_transition(t,j,type)                   Costs for lu transitions (mio. USD05MER per yr)
 ov10_lu_transitions(t,j,land_from10,land_to10,type) Land transitions between time steps (mio. ha)
 oq10_land(t,j,type)                                 Land conversion constraint (mio. ha)
 oq10_transition_matrix(t,j,type)                    Land transition constraint cell area (mio. ha)
 oq10_transition_to(t,j,land_to10,type)              Land transition constraint to (mio. ha)
 oq10_transition_from(t,j,land_from10,type)          Land transition constraint from (mio. ha)
 oq10_landexpansion(t,j,land_to10,type)              Land expansion constraint (mio. ha)
 oq10_landreduction(t,j,land_from10,type)            Land reduction constraint (mio. ha)
 oq10_croplandreduction(t,j,land_to10,type)          Cropland reduction constraint (mio. ha)
 oq10_croplandexpansion(t,j,land_from10,type)        Cropland expansion constraint (mio. ha)
 oq10_cost(t,j,type)                                 Costs for lu transitions (mio. USD05MER per yr)
 oq10_landdiff(t,type)                               Land difference constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
