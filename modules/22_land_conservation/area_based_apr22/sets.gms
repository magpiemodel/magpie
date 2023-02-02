*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

  consv22_all All conservation options
  / none, 30by30, KBA, GSN_DSA, GSN_RarePhen, GSN_AreaIntct, GSN_ClimTier1, GSN_ClimTier2, BH,
    IFL, BH_IFL, IrrC_30pc, IrrC_40pc, IrrC_50pc, IrrC_60pc, IrrC_70pc, IrrC_80pc, IrrC_90pc,
    IrrC_100pc, CCA, GSN_HalfEarth, PBL_HalfEarth /

  consv_prio22(consv22_all) Conservation priority areas
  / 30by30, KBA, GSN_DSA, GSN_RarePhen ,GSN_AreaIntct, GSN_ClimTier1, GSN_ClimTier2, BH,
    IFL, BH_IFL, IrrC_30pc, IrrC_40pc, IrrC_50pc, IrrC_60pc, IrrC_70pc, IrrC_80pc, IrrC_90pc,
    IrrC_100pc, CCA, GSN_HalfEarth, PBL_HalfEarth /

  consv_type Type of land conservation
  / protect, restore /

;
