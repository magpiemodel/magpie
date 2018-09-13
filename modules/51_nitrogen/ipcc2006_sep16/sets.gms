*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets
   emis_uncertainty51 Different estimates for emission parameters
   /best,low, high/

   ipcc_ef51 ipcc Emission factors
   /frac_gasf,frac_gasm,frac_leach,frac_leach_h,ef_1,ef_1fr,ef_2,ef_4,ef_5/

   emis_source_n51(emis_source) Emission sources from agriculture
   / inorg_fert, man_crop, awms, resid, man_past, som, rice /

   emis_source_nonitrogen51(emis_source) Emission sources
   / rice, ent_ferm,
     resid_burn,
     crop_vegc, crop_litc, crop_soilc,
     past_vegc, past_litc, past_soilc,
     forestry_vegc, forestry_litc, forestry_soilc,
     primforest_vegc, primforest_litc, primforest_soilc,
secdforest_vegc, secdforest_litc, secdforest_soilc,     urban_vegc, urban_litc, urban_soilc,
     other_vegc, other_litc, other_soilc,
     beccs/
;
