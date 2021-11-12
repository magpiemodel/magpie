*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s34_urban_deviation_cost Artificial cost for urban deviation variables (USD05MER per ha) / 1e+06 /
;

table f34_urbanland(t_all, j, gdp_scen09)     Urban land
$ondelim
$include "./modules/34_urban/exo_nov21/input/f34_urbanland.cs3"
$offdelim
;
