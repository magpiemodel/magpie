*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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