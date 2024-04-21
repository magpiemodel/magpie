*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c29_marginal_land  q33_marginal
* options: all_marginal, q33_marginal, no_marginal

********* AVAILABLE CROPLAND *******************************************

table f29_avl_cropland(j,marginal_land29) Available land area for cropland (mio. ha)
$ondelim
$include "./modules/29_cropland/input/avl_cropland.cs3"
$offdelim
;
