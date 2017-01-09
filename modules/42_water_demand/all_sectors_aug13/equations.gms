*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q42_water_demand("agriculture",j2)..  vm_watdem("agriculture",j2)*v42_irrig_eff(j2)
                                   =e=
                                    sum(kcr, vm_area(j2,kcr,"irrigated")*ic42_wat_req_k(j2,kcr))
                                    + sum(kli,vm_prod(j2,kli)*ic42_wat_req_k(j2,kli)*v42_irrig_eff(j2));
