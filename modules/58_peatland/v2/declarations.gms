*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pc58_peatland(j,land58)             Peatland area (mio. ha)
 pc58_manLand(j,manPeat58)           Managed land area (mio. ha)
 p58_scalingFactorExp(t,j)           Scaling factor for peatland expansion (1)
 p58_scalingFactorRed(t,j,manPeat58) Scaling factor for peatland reduction (1)
 p58_mapping_cell_climate(j,clcl58)  Mapping between cells and climate regions (binary)
 i58_cost_rewet_recur(t)             Recurring costs for rewetted peatland (USD05MER per ha)
 i58_cost_rewet_onetime(t)           One-time costs for peatland rewetting (USD05MER per ha)
 i58_cost_drain_recur(t)             Recurring costs for drained and managed peatlands (USD05MER per ha)
 i58_cost_drain_intact_onetime(t)    One-time costs for drainage of intact peatland (USD05MER per ha)
 i58_cost_drain_rewet_onetime(t)     One-time costs for drainage of rewetted peatland (USD05MER per ha)
 p58_availPeatlandExp(t,j)           Available area for expansion of drained peatland (mio. ha)
 p58_availLandExp(t,j)               Available area for expansion of managed land (mio. ha)
;

equations
 q58_peatland(j)                   Constraint for total peatland area (mio. ha)
 q58_peatlandChange(j,land58)      Peatland area change (mio. ha)
 q58_manLand(j,manPeat58)          Managed land area (mio. ha)
 q58_manLandExp(j,manPeat58)       Managed land area expansion (mio. ha)
 q58_manLandRed(j,manPeat58)       Managed land area reduction (mio. ha)
 q58_peatlandMan(j,manPeat58)      Change of managed peatland area (mio. ha)
 q58_peatlandMan2(j,manPeat58)     Contraint for managed peatland area (mio. ha)
 q58_peatland_cost(j)              One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 q58_peatland_cost_annuity(j,cost58)       Annuity costs for peatland conversion in the current timestep (mio. USD05MER per yr)
 q58_peatland_emis_detail(j,land58,emis58) Detailed GHG emissions from peatlands (Tg per yr)
 q58_peatland_emis(i,poll58)               GHG emissions from managed peatland (Tg per yr)
;

variables
 v58_peatlandChange(j,land58)       Peatland area change (mio. ha)
 vm_peatland_cost(j)                One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 v58_peatland_emis(j,land58,emis58) Detailed GHG peatland GHG emissions (Tg per yr)
;

positive variables
 v58_peatland(j,land58)            Peatland area (mio. ha)
 v58_manLand(j,manPeat58)          Managed land area (mio. ha)
 v58_manLandExp(j,manPeat58)       Managed land area expansion (mio. ha)
 v58_manLandRed(j,manPeat58)       Managed land area reduction (mio. ha)
 v58_balance(j,manPeat58)          Technical balance term for peatland scaling factor (1)
 v58_balance2(j,manPeat58)         Technical balance term for peatland scaling factor (1)
 v58_peatland_cost_annuity(j,cost58) Annuity costs for peatland conversion in the current timestep (mio. USD05MER per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov58_peatlandChange(t,j,land58,type)              Peatland area change (mio. ha)
 ov_peatland_cost(t,j,type)                        One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 ov58_peatland_emis(t,j,land58,emis58,type)        Detailed GHG peatland GHG emissions (Tg per yr)
 ov58_peatland(t,j,land58,type)                    Peatland area (mio. ha)
 ov58_manLand(t,j,manPeat58,type)                  Managed land area (mio. ha)
 ov58_manLandExp(t,j,manPeat58,type)               Managed land area expansion (mio. ha)
 ov58_manLandRed(t,j,manPeat58,type)               Managed land area reduction (mio. ha)
 ov58_balance(t,j,manPeat58,type)                  Technical balance term for peatland scaling factor (1)
 ov58_balance2(t,j,manPeat58,type)                 Technical balance term for peatland scaling factor (1)
 ov58_peatland_cost_annuity(t,j,cost58,type)       Annuity costs for peatland conversion in the current timestep (mio. USD05MER per yr)
 oq58_peatland(t,j,type)                           Constraint for total peatland area (mio. ha)
 oq58_peatlandChange(t,j,land58,type)              Peatland area change (mio. ha)
 oq58_manLand(t,j,manPeat58,type)                  Managed land area (mio. ha)
 oq58_manLandExp(t,j,manPeat58,type)               Managed land area expansion (mio. ha)
 oq58_manLandRed(t,j,manPeat58,type)               Managed land area reduction (mio. ha)
 oq58_peatlandMan(t,j,manPeat58,type)              Change of managed peatland area (mio. ha)
 oq58_peatlandMan2(t,j,manPeat58,type)             Contraint for managed peatland area (mio. ha)
 oq58_peatland_cost(t,j,type)                      One-time and recurring cost of peatland conversion and management (mio. USD05MER per yr)
 oq58_peatland_cost_annuity(t,j,cost58,type)       Annuity costs for peatland conversion in the current timestep (mio. USD05MER per yr)
 oq58_peatland_emis_detail(t,j,land58,emis58,type) Detailed GHG emissions from peatlands (Tg per yr)
 oq58_peatland_emis(t,i,poll58,type)               GHG emissions from managed peatland (Tg per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
