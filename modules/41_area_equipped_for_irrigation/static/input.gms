*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c41_initial_irrigation_area  LUH2v2

parameters
f41_irrig(j) Available area equipped for irrigation according to Siebert [AVL] (mio. ha)
/
$ondelim
$include "./modules/41_area_equipped_for_irrigation/input/avl_irrig.cs2"
$offdelim
/
;

parameters
f41_irrig_luh(t_ini41,j) Available area equipped for irrigation according to LUH [AVL] (mio. ha)
/
$ondelim
$include "./modules/41_area_equipped_for_irrigation/input/avl_irrig_luh_t.cs2"
$offdelim
/
;
m_fillmissingyears(f41_irrig_luh,"j");
