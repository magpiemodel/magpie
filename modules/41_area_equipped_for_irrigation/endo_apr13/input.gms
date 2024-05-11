*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c41_initial_irrigation_area  LUH2v2

scalars
s41_AEI_depreciation Depreciation rate in capital value of irrigation infrastructure (USD05PPP per USD05PPP) / 0 /
;

table f41_c_irrig(t_all,i) Irrigation investment costs (USD04MER per ha)
$ondelim
$include "./modules/41_area_equipped_for_irrigation/endo_apr13/input/f41_c_irrig.csv"
$offdelim
;

table
f41_irrig(t_ini41,j,aei41) Available area equipped for irrigation [AVL] (mio. ha)
$ondelim
$include "./modules/41_area_equipped_for_irrigation/input/avl_irrig.cs3"
$offdelim
;
