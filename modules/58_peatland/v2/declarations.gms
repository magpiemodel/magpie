*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 p58_scaling_factor(j)              Scaling factor for managed peatland (1)
 pc58_peatland(j,land58)            Peatland area (mio. ha)
 p58_mapping_cell_climate(j,clcl58) Mapping between cells and climate regions (binary)
 i58_cost_rewet_recur(t)            Recurring costs for rewetted peatland (USD05MER per ha)
 i58_cost_rewet_onetime(t)          One-time costs for peatland restoration (USD05MER per ha)
 i58_cost_degrad_recur(t)           Recurring costs for degraded peatland (USD05MER per ha)
 i58_cost_degrad_onetime(t)         One-time costs for peatland degradation (USD05MER per ha)
;

equations
 q58_peatland(j)               Constraint for peatland area (mio. ha)
 q58_expansion(j,land58)       Peatland expansion (mio. ha)
 q58_reduction(j,land58)       Peatland reduction (mio. ha)
 q58_peatland_crop(j)          Degraded peatland used as cropland (mio. ha)
 q58_peatland_past(j)          Degraded peatland used as pasture (mio. ha)
 q58_peatland_forestry(j)      Degraded peatland used for forestry (mio. ha)
 q58_peatland_cost_full(j)     One-time and recurring cost of peatland conversion and management including artifical balance cost (mio. USD05MER per yr)
 q58_peatland_cost(j)          One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 q58_peatland_cost_annuity(j)  Annuity costs of peatland conversion in the current timestep (mio. USD05MER per yr)
 q58_peatland_emis_detail(j,land58,emis58) Detailed GHG emissions from peatlands (Tg per yr)
 q58_peatland_emis(i,poll58)   GHG emissions from managed peatland (Tg per yr)
;

variables
 vm_peatland_cost(j)                One-time and recurring cost of managed peatland including artifical balance cost (mio. USD05MER per yr)
 v58_peatland_cost(j)               One-time and recurring cost of managed peatland (mio. USD05MER per yr)
 v58_peatland_cost_annuity(j)       Annuity costs of managed peatland expansion in the current timestep (mio. USD05MER per yr)
 v58_peatland_emis(j,land58,emis58) Detailed GHG peatland GHG emissions (Tg per yr)
;

positive variables
 v58_expansion(j,land58)          Peatland expansion (mio. ha)
 v58_reduction(j,land58)          Peatland reduction (mio. ha)
 v58_peatland(j,land58)           Managed peatland (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_peatland_cost(t,j,type)                        One-time and recurring cost of managed peatland including artifical balance cost (mio. USD05MER per yr)
 ov58_peatland_cost(t,j,type)                      One-time and recurring cost of managed peatland (mio. USD05MER per yr)
 ov58_peatland_cost_annuity(t,j,type)              Annuity costs of managed peatland expansion in the current timestep (mio. USD05MER per yr)
 ov58_peatland_emis(t,j,land58,emis58,type)        Detailed GHG peatland GHG emissions (Tg per yr)
 ov58_expansion(t,j,land58,type)                   Peatland expansion (mio. ha)
 ov58_reduction(t,j,land58,type)                   Peatland reduction (mio. ha)
 ov58_peatland(t,j,land58,type)                    Managed peatland (mio. ha)
 oq58_peatland(t,j,type)                           Constraint for peatland area (mio. ha)
 oq58_expansion(t,j,land58,type)                   Peatland expansion (mio. ha)
 oq58_reduction(t,j,land58,type)                   Peatland reduction (mio. ha)
 oq58_peatland_crop(t,j,type)                      Degraded peatland used as cropland (mio. ha)
 oq58_peatland_past(t,j,type)                      Degraded peatland used as pasture (mio. ha)
 oq58_peatland_forestry(t,j,type)                  Degraded peatland used for forestry (mio. ha)
 oq58_peatland_cost_full(t,j,type)                 One-time and recurring cost of peatland conversion and management including artifical balance cost (mio. USD05MER per yr)
 oq58_peatland_cost(t,j,type)                      One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 oq58_peatland_cost_annuity(t,j,type)              Annuity costs of peatland conversion in the current timestep (mio. USD05MER per yr)
 oq58_peatland_emis_detail(t,j,land58,emis58,type) Detailed GHG emissions from peatlands (Tg per yr)
 oq58_peatland_emis(t,i,poll58,type)               GHG emissions from managed peatland (Tg per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
