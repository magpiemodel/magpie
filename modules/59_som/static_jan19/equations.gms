*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The soil carbon content for cropland is calculated as sum of reduced topsoil density
*' and the reference soil carbon densities of the subsoil.
 q59_soilcarbon_cropland(j2) ..
 vm_carbon_stock(j2,"crop","soilc") =e=
      vm_land(j2,"crop") * sum(ct, i59_topsoilc_density(ct,j2) + i59_subsoilc_density(ct,j2));

*' Hereby we assume that cropland activities will just change the topsoil (here 30 cm) carbon density.

*' The soil carbon content for all other land use types is calculated based on the full profile soil carbon density:
 q59_soilcarbon_noncropland(j2,noncropland59) ..
 vm_carbon_stock(j2,noncropland59,"soilc") =e=
      sum(ct, vm_land(j2,noncropland59) * fm_carbon_density(ct,j2,noncropland59,"soilc"));
