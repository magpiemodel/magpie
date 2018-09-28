*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations


 q38_cost_prod_crop(i2,kcr) ..
  vm_cost_prod(i2,kcr) =e= sum((cell(i2,j2), w), vm_area(j2,kcr,w)*f38_region_yield(i2,kcr)
                            *vm_tau(i2)/fm_tau1995(i2)*f38_fac_req(kcr,w));


*' The equation above shows that factor requirement costs `vm_cost_prod` mainly
*' depend on area harvested `vm_area` and average regional land-use intensity
*' levels `vm_tau`. Multiplying the land-use intensity increase increases
*' since 1995 with average regional yields `f38_region_yield` gives the
*' average regional yield. Multiplied with the area under production it gives
*' the production of this location assuming an average yield. Multiplied with
*' estimated factor requirement costs per volume `f38_fac_req` returns the
*' total factor costs.
*'
*' The crop-and-water specific factor costs per volume of crop production
*' `f38_fac_req` are obtained from @narayanan_gtap7_2008. Splitting factors
*' costs into costs under irrigation and under rainfed production was performed
*' based on the methodology described in @Calzadilla2011GTAP.
*'
*' In this realization, regardless of the cellular productivity, the factor
*' costs per area are identical for all cells within a region. This implicitly
*' gives an incentive to allocate and concentrate production to highly
*' productive cells.
