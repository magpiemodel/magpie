*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

* Columns of f35_forest_lost_share, as produced by mrland's calcForestLossByDriver
  driver_source Source of forest disturbance
  / overall, shifting_cultivation /

* Classes summed under s35_forest_damage = 3
  combined_loss(driver_source) Combined loss from disturbances not modelled endogenously
  / shifting_cultivation /

  pol35 Land protection policy
  / none, npi, ndc /

  pol_stock35 Land types for land protection policies
  / forest, other /

  othertype35 Other land types
  / othernat, youngsecdf /

  shock_scen Scenario name of forest carbon shock
  / none, 002lin2030,004lin2030,008lin2030,016lin2030
   /

;
