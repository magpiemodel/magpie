*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

parameters
f40_distance(j) transport distance to urban center (minutes)
/
$ondelim
$include "./modules/40_transport/input/transport_distance.cs2"
$offdelim
/
;

parameter f40_transport_costs(k) Transport costs (US$04 per ton DM per minute)
/
$ondelim
$include "./modules/40_transport/gtap_nov12/input/f40_transport_costs.csv"
$offdelim
/;
