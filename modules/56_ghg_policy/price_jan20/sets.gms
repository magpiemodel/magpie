*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
   /R2M41-SSP2-Budg1300,R2M41-SSP2-Budg600,
	R2M41-SSP2-Budg950,R2M41-SSP2-NDC,R2M41-SSP2-NPi,
	SSPDB-SSP1-20-IMAGE,SSPDB-SSP1-20-REMIND-MAGPIE,
   	SSPDB-SSP1-26-IMAGE,SSPDB-SSP1-26-REMIND-MAGPIE,
   	SSPDB-SSP1-34-IMAGE,SSPDB-SSP1-34-REMIND-MAGPIE,
   	SSPDB-SSP1-37-REMIND-MAGPIE,
   	SSPDB-SSP1-45-IMAGE,SSPDB-SSP1-45-REMIND-MAGPIE,
   	SSPDB-SSP1-Ref-IMAGE,SSPDB-SSP1-Ref-REMIND-MAGPIE,
   	SSPDB-SSP2-18-MESSAGE-GLOBIOM,SSPDB-SSP2-19-MESSAGE-GLOBIOM,
   	SSPDB-SSP2-20-MESSAGE-GLOBIOM,SSPDB-SSP2-20-REMIND-MAGPIE,
   	SSPDB-SSP2-26-MESSAGE-GLOBIOM,SSPDB-SSP2-26-REMIND-MAGPIE,
   	SSPDB-SSP2-34-MESSAGE-GLOBIOM,SSPDB-SSP2-34-REMIND-MAGPIE,
   	SSPDB-SSP2-37-REMIND-MAGPIE,
   	SSPDB-SSP2-45-MESSAGE-GLOBIOM,SSPDB-SSP2-45-REMIND-MAGPIE,
   	SSPDB-SSP2-60-MESSAGE-GLOBIOM,SSPDB-SSP2-60-REMIND-MAGPIE,
   	SSPDB-SSP2-Ref-MESSAGE-GLOBIOM,SSPDB-SSP2-Ref-REMIND-MAGPIE,
   	SSPDB-SSP3-34-AIM-CGE,SSPDB-SSP3-45-AIM-CGE,
   	SSPDB-SSP3-60-AIM-CGE,SSPDB-SSP4-26-GCAM4,
   	SSPDB-SSP4-34-GCAM4,SSPDB-SSP4-45-GCAM4,
   	SSPDB-SSP4-60-GCAM4,SSPDB-SSP4-Ref-GCAM4,
   	SSPDB-SSP5-20-REMIND-MAGPIE,SSPDB-SSP5-26-REMIND-MAGPIE,
   	SSPDB-SSP5-34-REMIND-MAGPIE,SSPDB-SSP5-37-REMIND-MAGPIE,
   	SSPDB-SSP5-45-REMIND-MAGPIE,SSPDB-SSP5-60-REMIND-MAGPIE,
   	SSPDB-SSP5-Ref-REMIND-MAGPIE/

  scen56 emission policy scenarios
  / none, all, ssp, ssp_nosoil, redd+_nosoil, all_nosoil /

   emis_cell_one56(emis_source_cell) cellular oneoff emission sources
   /crop_vegc, crop_litc, crop_soilc, past_vegc, past_litc, past_soilc, forestry_vegc,
   forestry_litc, forestry_soilc, primforest_vegc, primforest_litc, primforest_soilc,
   secdforest_vegc, secdforest_litc, secdforest_soilc,
   urban_vegc, urban_litc, urban_soilc, other_vegc, other_litc, other_soilc/

   emis_reg_yr56(emis_source_reg) regional yearly emission sources
   /inorg_fert, man_crop, awms, resid, man_past, som,
   rice, ent_ferm,  beccs/

   ac_exp(ac) age-class corresponding to planning horion
;

$onempty
sets
   emis_cell_yr56(emis_source_cell) cellular yearly emission sources
   / /

   emis_reg_one56(emis_source_reg) regional oneoff emission sources
   / /
 ;
$offempty
