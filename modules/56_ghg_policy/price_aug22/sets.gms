*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
      R21M42-SDP-NDC,
      R21M42-SDP-NPi,
      R21M42-SDP-PkBudg1000,
      R21M42-SDP-PkBudg1100,
      R21M42-SDP-PkBudg900,
      R21M42-SSP1-NDC,
      R21M42-SSP1-NPi,
      R21M42-SSP1-PkBudg1100,
      R21M42-SSP1-PkBudg1300,
      R21M42-SSP1-PkBudg900,
      R21M42-SSP2-NDC,
      R21M42-SSP2-NPi,
      R21M42-SSP2-PkBudg1100,
      R21M42-SSP2-PkBudg1300,
      R21M42-SSP2-PkBudg900,
      R21M42-SSP5-NDC,
      R21M42-SSP5-NPi,
      R21M42-SSP5-PkBudg1100,
      R21M42-SSP5-PkBudg1300,
      R21M42-SSP5-PkBudg900,
      R2M41-SSP2-Budg1300,
      R2M41-SSP2-Budg600,
      R2M41-SSP2-Budg950,
      R2M41-SSP2-NDC,
      R2M41-SSP2-NPi,
      R32M46-SDP_MC-NDC,
      R32M46-SDP_MC-NPi,
      R32M46-SDP_MC-PkBudg650,
      R32M46-SSP1-NDC,
      R32M46-SSP1-NPi,
      R32M46-SSP1-PkBudg1050,
      R32M46-SSP1-PkBudg650,
      R32M46-SSP2EU-NDC,
      R32M46-SSP2EU-NPi,
      R32M46-SSP2EU-PkBudg1050,
      R32M46-SSP2EU-PkBudg650,
      R32M46-SSP5-NDC,
      R32M46-SSP5-NPi,
      R32M46-SSP5-PkBudg1050,
      R32M46-SSP5-PkBudg650,
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
      redd_nosoil_CH4GWP20,
      redd_nosoil_nopeat,
      redd_nosoil_peatCO2only,
      reddnatveg_nosoil,
      reddnatveg_nosoil_CH4GWP20,
      reddnatveg_nosoil_nopeat,
      reddnatveg_nosoil_peatCO2only,
      redd+_nosoil,
      redd+_nosoil_CH4GWP20,
      redd+_nosoil_nopeat,
      redd+_nosoil_peatCO2only,
      redd+natveg_nosoil,
      redd+natveg_nosoil_CH4GWP20,
      redd+natveg_nosoil_nopeat,
      redd+natveg_nosoil_peatCO2only,
      all_vegc,
      redd_vegc,
      reddnatveg_vegc,
      redd+_vegc,
      redd+natveg_vegc,
      sdp_cropeff,
      sdp_livestock,
      sdp_redd,
      sdp_soil,
      sdp_peatland,
      sdp_redd_soil,
      sdp_redd_soil_peat,
      sdp_all,
      gcs_lbs,
      gcs_res,
      ecoSysProtAll,
      ecoSysProtForest,
      ecoSysProtPrimForest,
      ecoSysProtOff,
      ecoSysProtAll_agMgmtExclN2O,
      ecoSysProtAll_agMgmtExclCH4,
      ecoSysProtAll_agMgmtOff,
      co2_reddnatveg_nosoil,
      co2_peatland,
      co2_reddnatveg_nosoil_peatland /

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
