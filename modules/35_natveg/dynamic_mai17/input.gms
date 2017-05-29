*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c35_protect_scenario  WDPA

table f35_protect_area(j,prot_type) conservation priority areas [mio. ha]
$ondelim
$include "./modules/35_natveg/input/protect_area.cs3"
$offdelim
;
