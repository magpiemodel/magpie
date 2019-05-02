*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Carbon stocks for primary forest, secondary forest or other natural land are calculated 
*' as the product of respective area and carbon density.
*' 
vm_carbon_stock.fx(j,"primforest",c_pools) =
          vm_land.l(j,"primforest")*fm_carbon_density(t,j,"primforest",c_pools);
*' 
vm_carbon_stock.fx(j,"secdforest",c_pools) =
          vm_land.l(j,"secdforest")*fm_carbon_density(t,j,"secdforest",c_pools);
*' 
vm_carbon_stock.fx(j,"other",c_pools) =
          vm_land.l(j,"other")*fm_carbon_density(t,j,"other",c_pools);
*' @stop
