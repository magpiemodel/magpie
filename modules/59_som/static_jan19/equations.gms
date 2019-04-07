*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The soil carbon content for cropland is calculated as a total for all cropland:
 q59_soilcarbon_cropland(j2) ..
 vm_carbon_stock(j2,"crop","soilc") =e=
      vm_land(j2,"crop") * sum(ct, i59_topsoilc_density(ct,j2) + i59_subsoilc_density(ct,j2));

 q59_soilcarbon_noncropland(j2,noncropland59) ..
 vm_carbon_stock(j2,noncropland59,"soilc") =e=
      sum(ct, vm_land(j2,noncropland59) * fm_carbon_density(ct,j2,noncropland59,"soilc"));
