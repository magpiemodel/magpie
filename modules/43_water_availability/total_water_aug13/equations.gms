*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q43_water(j2)  ..
   sum(wat_dem,vm_watdem(wat_dem,j2)) =l= sum(wat_src,v43_watavail(wat_src,j2))  ;

*' @description The water constraint, `q43_water`, assures that, in each
*' cluster, the sum of water withdrawals in all sectors `vm_watdem`
*' does not exceed available water from all sources `v43_watavail`.
*' The local seasonal water constraints is the sum of the amount of water needed
*' in the sectors defined by `wat_dem` (agriculture, industry, electricity,
*' domestic and ecosystem). This value must be lower than the sum of the Amount of
*' water available from different sources in the sectors defined by `wat_src` (surface,
*' ground, technical and renewable groundwater).
