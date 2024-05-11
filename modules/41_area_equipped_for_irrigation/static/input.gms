*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c41_initial_irrigation_area  LUH2v2

table
f41_irrig(t_ini41,j,aei41) Available area equipped for irrigation [AVL] (mio. ha)
$ondelim
$include "./modules/41_area_equipped_for_irrigation/input/avl_irrig.cs3"
$offdelim
;
