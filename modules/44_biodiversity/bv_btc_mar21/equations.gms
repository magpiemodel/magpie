*** (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q44_cost_bv_loss(j2) .. vm_cost_bv_loss(j2)
 					=e=
 					sum(landcover44, v44_bv_loss(j2,landcover44)) * pc44_price_bv_loss;

 q44_bv_loss(j2,landcover44) .. v44_bv_loss(j2,landcover44)
 					=e=
 					pc44_bv_weighted(j2,landcover44) - v44_bv_weighted(j2,landcover44);

 q44_bv_weighted(j2,landcover44) .. v44_bv_weighted(j2,landcover44)
 					=e=
 					f44_rr_layer(j2) * sum(potnatveg, vm_bv(j2,landcover44,potnatveg));

*** EOF constraints.gms ***
