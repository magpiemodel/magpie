*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  pol35 Land protection policy
  / none, npi, ndc /

  prot_type_all Conservation priority areas
  / BH, CPD, FF, LW, WDPA, HalfEarth, FF_BH, Forest, Forest_Other, PrimForest, SecdForest /

  prot_type(prot_type_all) Conservation priority areas
  / BH, CPD, FF, LW, WDPA, HalfEarth /

  pol_stock35 Land types for land protection policies
  / forest, other /

  driver_source Source of deforestation drivers
  / overall, deforestation, shifting_agriculture,
  forestry, wildfire, urbanization /

  combined_loss(driver_source) Combined loss from fire plus agriculture
  / shifting_agriculture,wildfire /

  prot_target35 Target year for nature protection
   / none, by2030, by2050 /

  shock_scen Scenario name of forest carbon shock
  / none,  20flt2030, 20flt2040, 20flt2050, 40lin2030, 40int2030,50one2050,
  01lin2030,02lin2030,05lin2030,10lin2030,15lin2030,20lin2030
   /

;
