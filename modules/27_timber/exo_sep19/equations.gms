*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

  q27_prod_timber(j2,kforestry)..
    vm_prod(j2,kforestry)
    =e=
    vm_prod_cell_forestry(j2,kforestry)
    +
    vm_prod_cell_natveg(j2,kforestry)
    +
    vm_prod_heaven_timber(j2,kforestry)
    ;

*' The equation above describes production of a MAgPIE timber commodity `vm_prod_cell_forestry`
*' and `vm_prod_cell_natveg` as the cluster level production for `vm_prod` for timber.
*' '`vm_prod` for wood and woodfuel can be produced from either highly managed plantation
*' forests or natural forests. The part of timber production coming from harvesting
*' of plantation forests is calculated in [32_forestry] module and the corresponding 
*' calculation for timber production coming from primary forest, secondadry forest
*' and other land is calculated in [35_natveg]

*** EOF constraints.gms ***
