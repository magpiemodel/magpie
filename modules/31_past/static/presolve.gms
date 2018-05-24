*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code Pasture areas are fixed to the initial spatially explicit patterns
*' defined in the module [10_land] by the land use input data set.

vm_land.fx(j,"past") = pcm_land(j,"past");

*' Correspondingly, also the carbon stocks related to pasture areas are fixed.

vm_carbon_stock.fx(j,"past",c_pools) =
          pcm_land(j,"past")*fm_carbon_density(t,j,"past",c_pools);

*' Regional costs associated with pasture management are set to zero.

vm_cost_prod.fx(i,"pasture") = 0;

*' @stop
