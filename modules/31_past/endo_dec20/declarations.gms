*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q31_carbon(j,ag_pools)   Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)    Costs for putting animals on pastures (mio. USD05MER per yr)
 q31_bv_manpast(j,potnatveg)    Biodiversity value for managed pastures (Mha)
 q31_bv_rangeland(j,potnatveg)    Biodiversity value for rangeland (Mha)
;

*marcos_develop
positive variables
v31_grass_area(j,grassland,w)    Grass production area (mio. ha)
v31_pos_balance(j, grassland)    Balance variable for grassland transitions (mio. ha)
v31_neg_balance(j, grassland)    Balance variable for grassland transitions (mio. ha)
v31_past_yld(j,grassland,w)           marcos_develop
;

parameters
i31_manpast_suit(t_all,j)        Areas suitable for managed pastures (mio. ha)
pc31_grass(j,grassland)           Grassland areas in previous time step (mio. ha)
i31_grass_calib(t_all,j,grassland)                      Regional grassland calibration factor correcting for FAO yield levels (1)
i31_grass_yields_hist(t_all,i,grassland)                Biophysical input yields average over region and grassland cover type at the historical reference year (tDM per ha per yr)
i31_grass_yields(t_all,j,grassland,w)                   Cellular biophysical input yields (tDM per ha per yr)
i31_grassland_total(t_all,j)                            Celullar grassland areas (mio. ha)
i31_lambda_grass(t,i,grassland)                         Grassland Scaling factor for non-linear management calibration (1)
i31_grassl_yld_hist_reg(t,i,grassland)                  Grassland FAO yields per region at the historical referende year (tDM per ha per yr)

;

equations
q31_pasture_areas(j)             Total grassland calculation (mio. ha)
q31_manpast_suitability(i)       Constraint on areas suitable for managed pastures (mio. ha)
q31_prod_pm(j)                   Cellular grass production constraint (mio. tDM per yr)

q31_transition_to(j,grass_to31)            Grassland transition constraint to (mio. ha)
q31_transition_from(j,grass_from31)        Grassland transition constraint from (mio. ha)
q31_grass_expansion(j)                     Grassland expansion constraint (mio. ha)
q31_grass_reduction(j)                     Grassland expansion reduction (mio. ha)
q31_cost_transition(j)                     Costs for grassland transitions (mio. USD05MER per yr)

q31_yield_grassl_range(j,grassland,w) marcos_develop
q31_yield_grassl_pastr(j,grassland,w) marcos_develop
;


positive variables
v31_grass_transitions(j,grass_from31,grass_to31)     Land transitions between time steps (mio. ha)
v31_cost_grass_transition(j)                         Costs for grassland transitions (mio. USD05MER per yr)
v31_grass_expansion(j,grassland)                     Targets of grassland expansion (mio. ha)
v31_grass_reduction(j,grassland)                     Sources of grassland expansion (mio. ha)
;


*marcos_develop

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov31_grass_area(t,j,grassland,w,type)                    Grass production area (mio. ha)
 ov31_pos_balance(t,j,grassland,type)                     Balance variable for grassland transitions (mio. ha)
 ov31_neg_balance(t,j,grassland,type)                     Balance variable for grassland transitions (mio. ha)
 ov31_past_yld(t,j,grassland,w,type)                      marcos_develop
 ov31_grass_transitions(t,j,grass_from31,grass_to31,type) Land transitions between time steps (mio. ha)
 ov31_cost_grass_transition(t,j,type)                     Costs for grassland transitions (mio. USD05MER per yr)
 ov31_grass_expansion(t,j,grassland,type)                 Targets of grassland expansion (mio. ha)
 ov31_grass_reduction(t,j,grassland,type)                 Sources of grassland expansion (mio. ha)
 oq31_carbon(t,j,ag_pools,type)                           Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)                            Costs for putting animals on pastures (mio. USD05MER per yr)
 oq31_bv_manpast(t,j,potnatveg,type)                      Biodiversity value for managed pastures (Mha)
 oq31_bv_rangeland(t,j,potnatveg,type)                    Biodiversity value for rangeland (Mha)
 oq31_pasture_areas(t,j,type)                             Total grassland calculation (mio. ha)
 oq31_manpast_suitability(t,i,type)                       Constraint on areas suitable for managed pastures (mio. ha)
 oq31_prod_pm(t,j,type)                                   Cellular grass production constraint (mio. tDM per yr)
 oq31_transition_to(t,j,grass_to31,type)                  Grassland transition constraint to (mio. ha)
 oq31_transition_from(t,j,grass_from31,type)              Grassland transition constraint from (mio. ha)
 oq31_grass_expansion(t,j,type)                           Grassland expansion constraint (mio. ha)
 oq31_grass_reduction(t,j,type)                           Grassland expansion reduction (mio. ha)
 oq31_cost_transition(t,j,type)                           Costs for grassland transitions (mio. USD05MER per yr)
 oq31_yield_grassl_range(t,j,grassland,w,type)            marcos_develop
 oq31_yield_grassl_pastr(t,j,grassland,w,type)            marcos_develop
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
