*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets

   pollutants_all all pollutants
   / co2_c,
   ch4,
   n2o_n_direct, nh3_n, no2_n,
   no3_n,
   n2o_n_indirect,
   co,
   nmhc,
   h2,
   pm2_5,
   tpm,
   tc,
   oc,
   bc,
   so2 /

   pollutants(pollutants_all) subset of pollutants_all that can be taxed
   / co2_c,
   ch4,
   n2o_n_direct, n2o_n_indirect,
   nh3_n, no2_n,
   no3_n /

   n_pollutants(pollutants) subset of n pollutants
   / n2o_n_direct,n2o_n_indirect,
   nh3_n, no2_n,
   no3_n /

   n_pollutants_direct(n_pollutants) subset of n pollutants
   / n2o_n_direct,
   nh3_n, no2_n,
   no3_n /

   pollutant_nh3no2_51(n_pollutants_direct) nitrogen emissions relevant for deposition
   / nh3_n, no2_n /

   emis_source_n_cropsoils51(emis_source) activities that lead to emissions
   / inorg_fert, man_crop, resid, som, rice /

   ghgscen56 ghg price scenarios
   /SSP1-20-SPA1-V15-IMAGE,SSP1-26-SPA1-V15-IMAGE,
    SSP1-34-SPA1-V15-IMAGE,SSP1-45-SPA1-V15-IMAGE,
    SSP1-Ref-SPA0-V15-IMAGE,

    SSP1-20-SPA1-V15-REMIND-MAGPIE,SSP1-26-SPA1-V15-REMIND-MAGPIE,
    SSP1-34-SPA1-V15-REMIND-MAGPIE,SSP1-37-SPA1-V15-REMIND-MAGPIE,
    SSP1-45-SPA1-V15-REMIND-MAGPIE,SSP1-Ref-SPA0-V15-REMIND-MAGPIE,

    SSP2-18-SPA2-V15-MESSAGE-GLOBIOM,SSP2-19-SPA2-V15-MESSAGE-GLOBIOM,
    SSP2-20-SPA2-V15-MESSAGE-GLOBIOM,SSP2-26-SPA2-V15-MESSAGE-GLOBIOM,
    SSP2-34-SPA2-V15-MESSAGE-GLOBIOM,SSP2-45-SPA2-V15-MESSAGE-GLOBIOM,
    SSP2-60-SPA2-V15-MESSAGE-GLOBIOM,SSP2-Ref-SPA0-V15-MESSAGE-GLOBIOM,

    SSP2-20-SPA2-V15-REMIND-MAGPIE,SSP2-26-SPA2-V15-REMIND-MAGPIE,
    SSP2-34-SPA2-V15-REMIND-MAGPIE,SSP2-37-SPA2-V15-REMIND-MAGPIE,
    SSP2-45-SPA2-V15-REMIND-MAGPIE,SSP2-60-SPA2-V15-REMIND-MAGPIE,
    SSP2-Ref-SPA0-V15-REMIND-MAGPIE,

    SSP3-34-SPA3-V15-AIM-CGE,SSP3-45-SPA3-V15-AIM-CGE,
    SSP3-60-SPA3-V15-AIM-CGE,

    SSP4-26-SPA4-V15-GCAM4,
    SSP4-34-SPA4-V15-GCAM4,SSP4-45-SPA4-V15-GCAM4,
    SSP4-60-SPA4-V15-GCAM4,SSP4-Ref-SPA0-V15-GCAM4,

    SSP5-20-SPA5-V15-REMIND-MAGPIE,SSP5-26-SPA5-V15-REMIND-MAGPIE,
    SSP5-34-SPA5-V15-REMIND-MAGPIE,SSP5-37-SPA5-V15-REMIND-MAGPIE,
    SSP5-45-SPA5-V15-REMIND-MAGPIE,SSP5-60-SPA5-V15-REMIND-MAGPIE,
    SSP5-Ref-SPA0-V15-REMIND-MAGPIE  /

  scen56 emission policy scenarios
  / none, all, ssp /

  aff56 afforestation policy scenarios
  / none, all, all50, vegc100, vegc75, vegc50, vegc33, vegc25 /

   emis_cell_one56(emis_source_cell) cellular oneoff emission sources
   /crop_vegc, crop_litc, crop_soilc, past_vegc, past_litc, past_soilc, forestry_vegc,
   forestry_litc, forestry_soilc, primforest_vegc, primforest_litc, primforest_soilc,
   secdforest_vegc, secdforest_litc, secdforest_soilc,
   urban_vegc, urban_litc, urban_soilc, other_vegc, other_litc, other_soilc/

   emis_reg_yr56(emis_source_reg) regional yearly emission sources
   /inorg_fert, man_crop, awms, resid, man_past, som,
   rice, ent_ferm,  beccs/
;

$onempty
sets
   emis_cell_yr56(emis_source_cell) cellular yearly emission sources
   / /

   emis_reg_one56(emis_source_reg) regional oneoff emission sources
   / /
 ;
$offempty