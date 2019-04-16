*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

$setglobal c43_watavail_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

parameters
f43_wat_avail(t_all,j) Surface water available for irrigation per cell from LPJmL (mio. m^3 per yr)
/
$ondelim
$include "./modules/43_water_availability/input/lpj_watavail_grper.cs2"
$offdelim
/
;
$if "%c43_watavail_scenario%" == "nocc" f43_wat_avail(t_all,j) = f43_wat_avail("y1995",j);
m_fillmissingyears(f43_wat_avail,"j");
