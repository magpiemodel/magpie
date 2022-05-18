*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_cost_bv_loss(j)					            Cost of biodiversity loss (mio USD)
 vm_bv(j,landcover44,potnatveg)		            Biodiversity stock for all land cover classes (unweighted) (Mha)
 v44_bii_glo                                 BII (1)
 v44_bii_reg(i)                                 BII (1)
 v44_bii_cell(j)                                 BII (1)
 v44_bii_realm(realm)                                 BII (1)
 v44_bii_realm_missing(realm)
;

parameters
 p44_bii_realm_target(t_all,realm)
;

equations
 q44_bii_glo                                 BII (1)
 q44_bii_reg(i)                                 BII (1)
 q44_bii_cell(j)                                 BII (1)
 q44_bii_realm(realm)                                 BII (1)
 q44_bii_realm2(realm)                                 BII (1)
 q44_cost_bv_loss
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_bv_loss(t,j,type)             Cost of biodiversity loss (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type) Biodiversity stock for all land cover classes (unweighted) (Mha)
 ov44_bii_glo(t,type)                  BII (1)
 ov44_bii_reg(t,i,type)                BII (1)
 ov44_bii_cell(t,j,type)               BII (1)
 ov44_bii_realm(t,realm,type)          BII (1)
 ov44_bii_realm_missing(t,realm,type)  
 oq44_bii_glo(t,type)                  BII (1)
 oq44_bii_reg(t,i,type)                BII (1)
 oq44_bii_cell(t,j,type)               BII (1)
 oq44_bii_realm(t,realm,type)          BII (1)
 oq44_bii_realm2(t,realm,type)         BII (1)
 oq44_cost_bv_loss(t,type)             
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

