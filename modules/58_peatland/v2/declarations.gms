*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p58_scaling_factor_exp(t,j)        Scaling factor for managed peatland expansion (1)
 p58_scaling_factor_red(t,j)        Scaling factor for managed peatland reduction (1)
 pc58_peatland(j,land58)            Peatland area (mio. ha)
 p58_mapping_cell_climate(j,clcl58) Mapping between cells and climate regions (binary)
 i58_cost_rewet_recur(t)            Recurring costs for rewetted peatland (USD05MER per ha)
 i58_cost_rewet_onetime(t)          One-time costs for peatland restoration (USD05MER per ha)
 i58_cost_degrad_recur(t)           Recurring costs for degraded peatland (USD05MER per ha)
 i58_cost_degrad_onetime(t)         One-time costs for peatland degradation (USD05MER per ha)
 p58_weight(t,j,manPeat58)          Weight for distribution of total peatland changes to managed peatland categories (1)
;

equations
 q58_peatland(j)                  Constraint for total peatland area (mio. ha)
 q58_peatlandChange(j,land58)     Peatland area Change (mio. ha)
 q58_peatlandMan(j,manPeat58)     Change of managed peatland area (mio. ha)
 q58_peatlandRewet(j)             Change of rewetted peatland area (mio. ha)
 q58_peatland_cost_full(j)        One-time and recurring cost of peatland conversion and management including artifical balance cost (mio. USD05MER per yr)
 q58_peatland_cost(j)             One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 q58_peatland_cost_annuity_intact(j)       Annuity costs for reduction of intact peatland in the current timestep (mio. USD05MER per yr)
 q58_peatland_cost_annuity_rewet(j)        Annuity costs for expansion of rewetted peatland in the current timestep (mio. USD05MER per yr)
 q58_peatland_emis_detail(j,land58,emis58) Detailed GHG emissions from peatlands (Tg per yr)
 q58_peatland_emis(i,poll58)               GHG emissions from managed peatland (Tg per yr)
 q58_manLandExp(j,manLand58)               Managed land expansion (mio. ha)
 q58_manLandRed(j,manLand58)               Managed land reduction (mio. ha)
;

variables
 vm_peatland_cost(j)                One-time and recurring cost of peatland conversion and management including artifical balance cost (mio. USD05MER per yr)
 v58_peatland_cost(j)               One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 v58_peatland_emis(j,land58,emis58) Detailed GHG peatland GHG emissions (Tg per yr)
 v58_peatlandChange(j,land58)       Peatland area change (mio. ha)
;

positive variables
 v58_peatland_cost_annuity_intact(j) Annuity costs for reduction of intact peatland in the current timestep (mio. USD05MER per yr)
 v58_peatland_cost_annuity_rewet(j)  Annuity costs for expansion of rewetted peatland in the current timestep (mio. USD05MER per yr)
 v58_peatland(j,land58)            Peatland area (mio. ha)
 v58_manLandExp(j,manLand58)       Managed land expansion (mio. ha)
 v58_manLandRed(j,manLand58)       Managed land reduction (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_peatland_cost(t,j,type)                        One-time and recurring cost of peatland conversion and management including artifical balance cost (mio. USD05MER per yr)
 ov58_peatland_cost(t,j,type)                      One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 ov58_peatland_emis(t,j,land58,emis58,type)        Detailed GHG peatland GHG emissions (Tg per yr)
 ov58_peatlandChange(t,j,land58,type)              Peatland area change (mio. ha)
 ov58_peatland_cost_annuity_intact(t,j,type)       Annuity costs for reduction of intact peatland in the current timestep (mio. USD05MER per yr)
 ov58_peatland_cost_annuity_rewet(t,j,type)        Annuity costs for expansion of rewetted peatland in the current timestep (mio. USD05MER per yr)
 ov58_peatland(t,j,land58,type)                    Peatland area (mio. ha)
 ov58_manLandExp(t,j,manLand58,type)               Managed land expansion (mio. ha)
 ov58_manLandRed(t,j,manLand58,type)               Managed land reduction (mio. ha)
 oq58_peatland(t,j,type)                           Constraint for total peatland area (mio. ha)
 oq58_peatlandChange(t,j,land58,type)              Peatland area Change (mio. ha)
 oq58_peatlandMan(t,j,manPeat58,type)              Change of managed peatland area (mio. ha)
 oq58_peatlandRewet(t,j,type)                      Change of rewetted peatland area (mio. ha)
 oq58_peatland_cost_full(t,j,type)                 One-time and recurring cost of peatland conversion and management including artifical balance cost (mio. USD05MER per yr)
 oq58_peatland_cost(t,j,type)                      One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 oq58_peatland_cost_annuity_intact(t,j,type)       Annuity costs for reduction of intact peatland in the current timestep (mio. USD05MER per yr)
 oq58_peatland_cost_annuity_rewet(t,j,type)        Annuity costs for expansion of rewetted peatland in the current timestep (mio. USD05MER per yr)
 oq58_peatland_emis_detail(t,j,land58,emis58,type) Detailed GHG emissions from peatlands (Tg per yr)
 oq58_peatland_emis(t,i,poll58,type)               GHG emissions from managed peatland (Tg per yr)
 oq58_manLandExp(t,j,manLand58,type)               Managed land expansion (mio. ha)
 oq58_manLandRed(t,j,manLand58,type)               Managed land reduction (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
