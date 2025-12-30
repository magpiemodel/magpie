*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variable
 vm_tau(j,tautype)                    Overall agricultural land use intensity tau at cluster level (1)
 vm_tech_cost(i)                      Costs of TC (mio. USD17MER per yr)
;

parameters
 p13_cost_tc(i,tautype)               Technical change costs per region (mio. USD17MER)
 pc13_land(i,tautype)                 Crop and grass land area per region (mio ha)
 pcm_tau(j,tautype)                   Tau factor of the previous time step (1)
 pc13_tau(h, tautype)                 Tau for conventional cropland  of the previous time step (1)
 pc13_tau_consv(h, tautype)           Tau for cropland within conservation priority areas of the previous time step (1)
 i13_tc_factor(t)                     Regression factor (USD17MER per ha)
 i13_tc_exponent(t)                   Regression exponent (1)
 p13_tech_cost(i,tautype)             Annuitized costs of TC for crops and pasture (mio. USD17MER per yr)
 p13_tau_core(h,tautype)                   Agricultural land use intensity tau for conventional cropland (1)
 p13_tau_consv(h,tautype)             Tau for cropland within conservation priority areas (1)
 p13_cropland_consv_shr(t,j)          Share of cropland within conservation priority areas(1)
 p13_croparea_consv_tau_factor(h)     Regional tau factor for crop area conservation (1)
 i13_croparea_consv_fader(t_all)      Crop area conservation fader (1)
 i13_tau_croparea_consv_fader(t_all)  Fader for tau factor for crop area conservation (1)
 p13_country_weight(i)                Policy country weight per region (1)
 p13_country_switch(iso)              Switch indicating whether country is affected by selected cropland policy (1)
 p13_country_wght_supreg(h)           Policy country weight per super region (1)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tau(t,j,tautype,type) Overall agricultural land use intensity tau at cluster level (1)
 ov_tech_cost(t,i,type)   Costs of TC (mio. USD17MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
