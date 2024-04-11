*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s40_pasture_transport_costs  Transport costs for pasture (USD05MER per tDM per min)     / 0 /
;


parameters
f40_distance(j) Transport distance to urban center (min)
/
$ondelim
$include "./modules/40_transport/input/transport_distance.cs2"
$offdelim
/
;

parameter f40_transport_costs(kall) Relative transport costs (USD05MER per tDM per min)
/
$ondelim
$include "./modules/40_transport/gtap_nov12/input/f40_transport_costs.csv"
$offdelim
/;

f40_transport_costs("pasture") = s40_pasture_transport_costs;
