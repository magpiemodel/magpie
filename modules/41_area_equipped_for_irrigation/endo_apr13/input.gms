*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

table f41_c_irrig(t_all,i) Irrigation investment costs (USD04MER per ha)
$ondelim
$include "./modules/41_area_equipped_for_irrigation/endo_apr13/input/f41_c_irrig.csv"
$offdelim
;

parameters
f41_irrig(j) Available area equipped for irrigation [AVL] (mio. ha) 
/
$ondelim
$include "./modules/41_area_equipped_for_irrigation/input/avl_irrig.cs2"
$offdelim
/
;
