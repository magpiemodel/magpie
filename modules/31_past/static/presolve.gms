*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

vm_land.fx(j,"past",si) = pcm_land(j,"past",si);

vm_carbon_stock.fx(j,"past",c_pools) =
          sum(si, pcm_land(j,"past",si)*fm_carbon_density(t,j,"past",c_pools));