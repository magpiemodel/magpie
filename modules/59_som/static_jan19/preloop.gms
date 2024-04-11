*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


* starting value of carbon stocks 1995 is only an estimate.
* ATTENTION: emissions in 1995 are not meaningful
vm_carbon_stock.l(j,land,"soilc","actual") = fm_carbon_density("y1995",j,land,"soilc") * pcm_land(j,land);
*pcm_carbon_stock(j,land,"soilc") = vm_carbon_stock.l(j,land,"soilc");

* Soilc is not different for all non cropland vegetated land types
* No age-class soil carbon density distribution is nessessary

*' @code Cropland topsoil carbon densities are calculated based on simple IPCC stock change factors
*' (if not done in cellular preprocessing). We assume following the IPCC assumptions that cropland activities
*' will only change the topsoil (here 30 cm) carbon density.
i59_subsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"secdforest","soilc") - f59_topsoilc_density(t_all,j);
$ifthen "%c59_static_spatial_level%" == "cellular" i59_topsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"crop","soilc") - i59_subsoilc_density(t_all,j);
$elseif "%c59_static_spatial_level%" == "cluster"  i59_topsoilc_density(t_all,j) = f59_topsoilc_density(t_all,j) * (1- f59_cshare_released(j));
$endif
