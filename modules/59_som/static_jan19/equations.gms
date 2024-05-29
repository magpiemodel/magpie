*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The soil carbon content for cropland is calculated as sum of reduced topsoil density
*' and the reference soil carbon densities of the subsoil.
 q59_soilcarbon_cropland(j2,stockType) ..
 vm_carbon_stock(j2,"crop","soilc",stockType) =e=
      (sum((kcr,w), vm_area(j2,kcr,w)) + vm_fallow(j2)) * sum(ct, i59_topsoilc_density(ct,j2) + i59_subsoilc_density(ct,j2))
      + vm_treecover(j2) * sum(ct, fm_carbon_density(ct,j2,"secdforest","soilc"));

*' The soil carbon content for all other land use types is calculated based on the full profile soil carbon density:
 q59_soilcarbon_regular(j2,regularland59,stockType) ..
 vm_carbon_stock(j2,regularland59,"soilc",stockType) =e=
      sum(ct, vm_land(j2,regularland59) * fm_carbon_density(ct,j2,regularland59,"soilc"));

q59_soilcarbon_other(j2,stockType) ..
 vm_carbon_stock(j2,"other","soilc",stockType) =e=
      sum((ct,ac), vm_land_other(j2,"othernat",ac) * fm_carbon_density(ct,j2,"other","soilc"))
    + sum((ct,ac), vm_land_other(j2,"youngsecdf",ac) * fm_carbon_density(ct,j2,"secdforest","soilc")) ;



