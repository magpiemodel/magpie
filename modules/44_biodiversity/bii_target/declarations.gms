*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_cost_bv_loss(j)           Biodiversity cost (mio USD)
 vm_bv(j,landcover44,potnatveg)     Biodiversity stock for all land cover classes (Mha)
 v44_bii(i,biome44)           Biodiversity Intactness Index BII (1)
 v44_bii_missing(i,biome44)       Missing BII increase for compliance with BII target (1)
;

parameters
 p44_bii_lower_bound(t,i,biome44)   Interpolated lower bound for BII over time (1)
 p44_start_value(i,biome44)       Start value for BII lower bound (1)
 p44_target_value(i,biome44)      Target value for BII lower bound (1)
;

equations
 q44_bii(i,biome44)                     Biodiversity Intactness Index BII (1)
 q44_bii_target(i,biome44)              Missing BII increase for compliance with BII target (1)
 q44_cost(i)              Biodiversity cost (mio USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_bv_loss(t,j,type)             Biodiversity cost (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type) Biodiversity stock for all land cover classes (Mha)
 ov44_bii(t,i,biome44,type)            Biodiversity Intactness Index BII (1)
 ov44_bii_missing(t,i,biome44,type)    Missing BII increase for compliance with BII target (1)
 oq44_bii(t,i,biome44,type)            Biodiversity Intactness Index BII (1)
 oq44_bii_target(t,i,biome44,type)     Missing BII increase for compliance with BII target (1)
 oq44_cost(t,i,type)                   Biodiversity cost (mio USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

