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

  scen2nd60 second generation bioenergy scenarios
    / R2M41-SSP2-Budg1300,
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
      SSPDB-SSP2-19-REMIND-MAGPIE,
      SSPDB-SSP2-26-REMIND-MAGPIE,
      SSPDB-SSP2-34-REMIND-MAGPIE,
      SSPDB-SSP2-45-REMIND-MAGPIE,
      SSPDB-SSP2-60-REMIND-MAGPIE,
      SSPDB-SSP2-Ref-REMIND-MAGPIE,
      SSPDB-SSP5-19-REMIND-MAGPIE,
      SSPDB-SSP5-26-REMIND-MAGPIE,
      SSPDB-SSP5-34-REMIND-MAGPIE,
      SSPDB-SSP5-45-REMIND-MAGPIE,
      SSPDB-SSP5-60-REMIND-MAGPIE,
      SSPDB-SSP5-Ref-REMIND-MAGPIE /

;
*######################### R SECTION END (SETS) ################################
*###############################################################################

sets

   kbe60(kall) bio energy activities
        / betr, begr /

   k1st60(kall) 1st generation bioenergy carriers
        / oils, ethanol /

   scen1st60 first generation bioenergy scenarios
       / const2020, const2030, phaseout2020 /

   scen2ndres60 residues for second generation bioenergy scenarios
       / ssp1, ssp2, ssp3, ssp4, ssp5, sdp, off /

;
