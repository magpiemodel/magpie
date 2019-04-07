*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* starting value of carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful
vm_carbon_stock.l(j,land,"soilc") = fm_carbon_density("y1995",j,land,"soilc") * pcm_land(j,land);
pcm_carbon_stock(j,land,"soilc") = vm_carbon_stock.l(j,land,"soilc");

* Soilc is not different for all non cropland vegetated land types
* No age-class soil carbon density distribution is nessessary

* calculate cropland soil carbon based on IPCC stock change factors (if not done in cellular preprocessing)
i59_subsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"secdforest","soilc") - f59_topsoilc_density(t_all,j);
$ifthen "%c59_static_spatial_level%" == "cellular" i59_topsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"crop","soilc") - i59_subsoilc_density(t_all,j);
$elseif "%c59_static_spatial_level%" == "cluster"  i59_topsoilc_density(t_all,j) = f59_topsoilc_density(t_all,j) * (1- f59_cshare_released(j));
$endif
