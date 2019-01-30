*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

i59_subsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"secdforest","soilc") - f59_topsoilc_density(t_all,j)
$ifthen "%c59_static_spatial_level%" == "cellular" i59_topsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"crop","soilc") - i59_subsoilc_density(t_all,j);
$elseif "%c59_static_spatial_level%" == "cluster"  i59_topsoilc_density(t_all,j) = f59_topsoilc_density(t_all,j) * f59_cshare_released(j);
