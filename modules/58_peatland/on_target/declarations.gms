*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p58_scaling_factor(t,j)							Scaling factor for managed peatland (1)
 p58_intact_ratio(t,j)								Ratio of intact and total peatland (1)
 p58_peatland_degrad_used(j)						Intermediate calculation in peatland initialization (mio. ha)
 p58_peatland_degrad_unused(j)						Intermediate calculation in peatland initialization (mio. ha)
 p58_peatland_degrad_unused_weight(j,land58)		Weight for intermediate calculation in peatland initialization (1)
 p58_land_area(j)									Total land area (mio. ha)
 p58_peatland_area(j)								Total peatland area (mio. ha)
 p58_ipcc_wetland_ef(clcl58,land58,emis58,man58) Wetland GWP100 emission factors (t CO2eq per ha)
 pc58_man_land(j)									Total managed land (mio. ha)
 pc58_man_land_shr(j,land58)						Share of total managed land (1)
 pc58_peatland_man(j,man58,land58)					Managed peatland (mio. ha)
 pc58_peatland_man_inital(j,man58,land58)			Managed peatland at initialization (mio. ha)
 pc58_peatland_intact(j)							Intact peatland (mio. ha)
 p58_mapping_cell_climate(j,clcl58)					Mapping between cells and climate regions (binary)
 p58_peatland_degrad_weight(j,land58)				Weight for peatland distribution to land58 (1)
 i58_cost_degrad_recur(t)							Fader (1)
;

equations
 q58_transition_matrix(j)						Peatland transitions (mio. ha)
 q58_transition_to(j,to58)						Peatland transitions to (mio. ha)
 q58_transition_from(j,from58)					Peatland transitions from (mio. ha)
 q58_expansion(j,to58)							Peatland expansion (mio. ha)
 q58_reduction(j,from58)						Peatland reduction (mio. ha)
 q58_peatland_degrad(j,land58)					Constraint for peatland degradation (mio. ha)
 q58_peatland_rewet(j)							Constraint for peatland rewetting (mio. ha)
 q58_peatland_cost(j)							One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 q58_peatland_cost_annuity(j)					Annuity costs of peatland conversion in the current timestep (mio. USD05MER per yr)
 q58_peatland_emis_detail(j,emis58)				Detailed GHG emissions from managed peatland (t CO2eq per year)
 q58_peatland_emis(j)							GHG emissions from managed peatland (t CO2eq per year)
 ;

variables
 v58_peatland_emis(j,emis58)				Detailed GHG emissions from managed peatland (t CO2eq per year)
;

positive variables
 vm_peatland_cost(j)						One-time and recurring cost of managed peatland (mio. USD05MER per yr)
 v58_peatland_cost_annuity(j)				Annuity costs of managed peatland expansion in the current timestep (mio. USD05MER per yr)
 v58_lu_transitions(j,from58,to58)			Peatland transitions (mio. ha)
 v58_expansion(j,stat58)					Peatland expansion (mio. ha)
 v58_reduction(j,stat58)					Peatland reduction (mio. ha)
 vm_peatland_emis(j) 						GHG emissions from managed peatland (t CO2eq per year)
 v58_peatland_man(j,man58,land58)			Managed peatland (mio. ha)
 v58_peatland_intact(j)						Intact peatland (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_peatland_cost(t,j,type)                 One-time and recurring cost of managed peatland (mio. USD05MER per yr)
 ov58_peatland_cost_annuity(t,j,type)       Annuity costs of managed peatland expansion in the current timestep (mio. USD05MER per yr)
 ov58_peatland_emis(t,j,emis58,type)        Detailed GHG emissions from managed peatland (t CO2eq per year)
 ov58_lu_transitions(t,j,from58,to58,type)  Peatland transitions (mio. ha)
 ov58_expansion(t,j,stat58,type)            Peatland expansion (mio. ha)
 ov58_reduction(t,j,stat58,type)            Peatland reduction (mio. ha)
 ov_peatland_emis(t,j,type)                 GHG emissions from managed peatland (t CO2eq per year)
 ov58_peatland_man(t,j,man58,land58,type)   Managed peatland (mio. ha)
 ov58_peatland_intact(t,j,type)             Intact peatland (mio. ha)
 oq58_transition_matrix(t,j,type)           Peatland transitions (mio. ha)
 oq58_transition_to(t,j,to58,type)          Peatland transitions to (mio. ha)
 oq58_transition_from(t,j,from58,type)      Peatland transitions from (mio. ha)
 oq58_expansion(t,j,to58,type)              Peatland expansion (mio. ha)
 oq58_reduction(t,j,from58,type)            Peatland reduction (mio. ha)
 oq58_peatland_degrad(t,j,land58,type)      Constraint for peatland degradation (mio. ha)
 oq58_peatland_rewet(t,j,type)              Constraint for peatland rewetting (mio. ha)
 oq58_peatland_cost(t,j,type)               One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 oq58_peatland_cost_annuity(t,j,type)       Annuity costs of peatland conversion in the current timestep (mio. USD05MER per yr)
 oq58_peatland_emis_detail(t,j,emis58,type) Detailed GHG emissions from managed peatland (t CO2eq per year)
 oq58_peatland_emis(t,j,type)               GHG emissions from managed peatland (t CO2eq per year)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
