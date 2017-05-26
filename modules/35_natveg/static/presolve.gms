*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

vm_carbon_stock.fx(j,"primforest",c_pools) =
          vm_land.l(j,"primforest")*fm_carbon_density(t,j,"primforest",c_pools);

vm_carbon_stock.fx(j,"secdforest",c_pools) =
          vm_land.l(j,"secdforest")*fm_carbon_density(t,j,"secdforest",c_pools);

vm_carbon_stock.fx(j,"other",c_pools) =
          vm_land.l(j,"other")*fm_carbon_density(t,j,"other",c_pools);
