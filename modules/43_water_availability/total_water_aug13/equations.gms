*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

 q43_water(j2)  ..
   sum(wat_dem,vm_watdem(wat_dem,j2)) =l= sum(wat_src,v43_watavail(wat_src,j2))  ;

*' @description The water constraint, `q43_water`, assures that, in each
*' cluster, the sum of water withdrawals in all sectors `vm_watdem`
*' does not exceed available water from all sources `v43_watavail`.
*' The local seasonal water constraints is the sum of the amount of water needed
*' in the sectors defined by `wat_dem` (agriculture, manufacturing, electricity,
*' domestic and ecosystem). This value must be lower than the sum of the Amount of
*' water available from different sources in the sectors defined by `wat_src` (surface,
*' ground, technical and renewable groundwater).
