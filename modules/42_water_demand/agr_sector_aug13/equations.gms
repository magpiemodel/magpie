*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q42_water_demand("agriculture",j2) ..
 vm_watdem("agriculture",j2) * v42_irrig_eff(j2) =e=
   sum(kcr, vm_area(j2,kcr,"irrigated") *
   ic42_wat_req_k(j2,kcr))
 + sum(kli, vm_prod(j2,kli) * ic42_wat_req_k(j2,kli) * v42_irrig_eff(j2));

 q42_water_cost(i2) ..
   vm_water_cost(i2) =e= sum(cell(i2,j2), vm_watdem("agriculture",j2)) * ic42_pumping_cost(i2);

*' `vm_watdem` is composed by irrigation and livestock demand uses.
*' The factor `v42_irrig_eff` corresponds to the amount of water that is used
*' inefficiently in the irrigation process.
