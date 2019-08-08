*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c59_static_spatial_level  cellular
*   options:   cellular  (use preprocessed cellular stock change factors)
*              cluster   (use cshare_released on cluster within gams)

$setglobal c59_som_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

parameters f59_topsoilc_density(t_all,j) LPJ topsoil carbon density for natural vegetation (tC per ha)
/
$ondelim
$include "./modules/59_som/input/lpj_carbon_topsoil.cs2"
$offdelim
/
;
$if "%c59_som_scenario%" == "nocc" f59_topsoilc_density(t_all,j) = f59_topsoilc_density("y1995",j);
m_fillmissingyears(f59_topsoilc_density,"j");

parameters f59_cshare_released(j) Share of soil carbon that is released on cropland compared to natural vegetation after 20 years (1)
/
$ondelim
$include "./modules/59_som/static_jan19/input/cshare_released.cs2"
$offdelim
/
;
