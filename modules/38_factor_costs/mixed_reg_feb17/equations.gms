*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @equations


q38_cost_prod_crop(i2,req) ..
    vm_cost_prod_crop(i2,req)  =e= (sum((cell(i2,j2), supreg(h2,i2), w, kcr), vm_area(j2,kcr,w)*f38_region_yield(i2,kcr)
                            * vm_tau(h2,"crop")/fm_tau1995(h2)*p38_fac_req(i2,kcr,w))) * sum(ct,p38_cost_share(ct,i2,req));


*' The equation above shows that factor requirement costs `vm_cost_prod_costs` mainly
*' depend on area harvested `vm_area` and average regional land-use intensity
*' levels `vm_tau`. Multiplying the land-use intensity increase increases
*' since 1995 with average regional yields `f38_region_yield` gives the
*' average regional yield. Multiplied with the area under production it gives
*' the production of this location assuming an average yield. Multiplied with
*' estimated factor requirement costs per volume `p38_fac_req` returns the
*' total factor costs, which multiplied by p38_cost_share gives us a results costs differentiated
*' by factor (capital or labor)'.
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
