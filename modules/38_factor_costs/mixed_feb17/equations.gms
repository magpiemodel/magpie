*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations


 q38_cost_prod_crop(i2,kcr) ..
  vm_cost_prod(i2,kcr) =e= sum((cell(i2,j2), w), vm_area(j2,kcr,w)*f38_region_yield(i2,kcr)
                            *vm_tau(i2)/fm_tau1995(i2)*f38_fac_req(kcr,w));


*' The equation above shows that factor requirement costs (`vm_cost_prod`) mainly depend on area harvested (`vm_area`).
*' The crop-and-water specific factor costs per tone of crop production (`f38_fac_req`)
*' are obtained from a cross-country regression linking value-added costs extracted
*' from @narayanan_gtap7_2008 and crop production from @FAOSTAT.
*' The factor costs extracted from @narayanan_gtap7_2008
*' are similar to the former realization of this module.
*' We refer the reader to @Calzadilla2011GTAP for more on extracting costs of irrigation from total land rents in @narayanan_gtap7_2008.
*' We, then, use crop-specific regional yields (`f38_region_yield`) to convert
*' these average global crop-specific per tone costs into region-crop-specific per hectare costs.
*' The equation also shows that factor costs at each time step will be influenced by the growth of agricultural land intensity (`vm_tau`)
*' relative to the initial (of 1995) agricultural land intensity (`fm_tau1995`).
*' This is based on empirical observation (cf. @dietrich_measuring_2012 and @dietrich_forecasting_2014)
*' such that factor costs move together with costs of agricultural technology change.
*' The latter influences agricultural land use intensity.
*' Of course, the positive association between factor costs
*' and costs of technological changes somehow reflects the substitutability
*' between factors and productivity enhancing technologies.
*' Making factor costs dependent on area imposes constraint on cropland land expansion.
*' Nonetheless, regardless of the cellular productivity, the factor costs per hectare will remain the same for all cells within a region.
*' This implicitly gives an incentive to allocate and concentrate production to highly productive cells
*' within the region and to productive regions among world regions.
