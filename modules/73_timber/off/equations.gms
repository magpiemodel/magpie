*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Timber production cost covering cost of harvest as well as the cost incurred by
*' utilizing free variable with a very high cost. Ideally this free variable is only
*' used when there is no other way to meet timber demand.

q73_cost_timber(i2)..
                    vm_cost_timber(i2)
                    =e=
                    sum((cell(i2,j2),kforestry), v73_prod_heaven_timber(j2,kforestry)) * s73_free_prod_cost
                    ;

*' The following equation describes cellular level production (in dry matter) of
*' woody biomass `vm_prod_reg` as the sum of the cluster level production of
*' timber coming from 'v73_prod_forestry' and 'v73_prod_natveg'.

q73_prod_timber(j2,kforestry)..
  vm_prod(j2,kforestry)
  =e=
  v73_prod_heaven_timber(j2,kforestry);
  ;

*** EOF equations.gms ***
