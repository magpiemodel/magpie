*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*###############################################################################
*######################## R SECTION START (SETS) ###############################
* THIS CODE IS CREATED AUTOMATICALLY, DO NOT MODIFY THESE LINES DIRECTLY
* ANY DIRECT MODIFICATION WILL BE LOST AFTER NEXT AUTOMATIC UPDATE!

sets

  ghgscen56 ghg price scenarios
    / PIK_GDP,
      PIK_H2C,
      PIK_HBL,
      PIK_HOS,
      PIK_LIN,
      PIK_NPI,
      PIK_OPT,
      R21M42-SDP-NPi,
      R21M42-SDP-PkBudg1000,
      R21M42-SDP-PkBudg1100,
      R21M42-SDP-PkBudg900,
      R21M42-SSP1-NPi,
      R21M42-SSP1-PkBudg1100,
      R21M42-SSP1-PkBudg1300,
      R21M42-SSP1-PkBudg900,
      R21M42-SSP2-NPi,
      R21M42-SSP2-PkBudg1100,
      R21M42-SSP2-PkBudg1300,
      R21M42-SSP2-PkBudg900,
      R21M42-SSP5-NPi,
      R21M42-SSP5-PkBudg1100,
      R21M42-SSP5-PkBudg1300,
      R21M42-SSP5-PkBudg900,
      R2M41-SSP2-Budg1300,
      R2M41-SSP2-Budg600,
      R2M41-SSP2-Budg950,
      R2M41-SSP2-NDC,
      R2M41-SSP2-NPi,
      SSPDB-SSP1-19-IMAGE,
      SSPDB-SSP1-19-REMIND-MAGPIE,
      SSPDB-SSP1-26-IMAGE,
      SSPDB-SSP1-26-REMIND-MAGPIE,
      SSPDB-SSP1-34-IMAGE,
      SSPDB-SSP1-34-REMIND-MAGPIE,
      SSPDB-SSP1-45-IMAGE,
      SSPDB-SSP1-45-REMIND-MAGPIE,
      SSPDB-SSP1-Ref-IMAGE,
      SSPDB-SSP1-Ref-REMIND-MAGPIE,
      SSPDB-SSP2-19-MESSAGE-GLOBIOM,
      SSPDB-SSP2-19-REMIND-MAGPIE,
      SSPDB-SSP2-26-MESSAGE-GLOBIOM,
      SSPDB-SSP2-26-REMIND-MAGPIE,
      SSPDB-SSP2-34-MESSAGE-GLOBIOM,
      SSPDB-SSP2-34-REMIND-MAGPIE,
      SSPDB-SSP2-45-MESSAGE-GLOBIOM,
      SSPDB-SSP2-45-REMIND-MAGPIE,
      SSPDB-SSP2-60-MESSAGE-GLOBIOM,
      SSPDB-SSP2-60-REMIND-MAGPIE,
      SSPDB-SSP2-Ref-MESSAGE-GLOBIOM,
      SSPDB-SSP2-Ref-REMIND-MAGPIE,
      SSPDB-SSP3-34-AIM-CGE,
      SSPDB-SSP3-45-AIM-CGE,
      SSPDB-SSP3-60-AIM-CGE,
      SSPDB-SSP4-26-GCAM4,
      SSPDB-SSP4-34-GCAM4,
      SSPDB-SSP4-45-GCAM4,
      SSPDB-SSP4-60-GCAM4,
      SSPDB-SSP4-Ref-GCAM4,
      SSPDB-SSP5-19-REMIND-MAGPIE,
      SSPDB-SSP5-26-REMIND-MAGPIE,
      SSPDB-SSP5-34-REMIND-MAGPIE,
      SSPDB-SSP5-45-REMIND-MAGPIE,
      SSPDB-SSP5-60-REMIND-MAGPIE,
      SSPDB-SSP5-Ref-REMIND-MAGPIE /

  scen56 emission policy scenarios
    / none,
      all,
      all_nosoil,
      redd_nosoil,
      redd+_nosoil,
      redd+natveg_nosoil,
      maccs_excl_cropland_n2o,
      sdp_cropeff,
      sdp_livestock,
      sdp_redd,
      sdp_soil,
      sdp_redd_soil,
      all_vegc,
      redd_vegc,
      redd+_vegc,
      redd+natveg_vegc,
      sdp_peatland,
      sdp_all,
      sdp_allnosoil /

;
*######################### R SECTION END (SETS) ################################
*###############################################################################

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

   ac_exp(ac) age-class corresponding to planning horizon

   ag_pools(c_pools) Above ground carbon pools
         / vegc, litc /

   stockType Carbon stock types
         / actual, actualNoAcEst /
;
