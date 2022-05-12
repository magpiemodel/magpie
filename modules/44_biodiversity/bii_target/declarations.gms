*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

variables
 vm_cost_bv_loss(j)					            Cost of biodiversity loss (mio USD)
;

positive variables
 vm_bv(j,landcover44,potnatveg)		            Biodiversity stock for all land cover classes (unweighted) (Mha)
 v44_bii_glo                                 BII (1)
 v44_bii_reg(i)                                 BII (1)
 v44_bii_cell(j)                                 BII (1)
;

equations
 q44_bii_glo                                 BII (1)
 q44_bii_reg(i)                                 BII (1)
 q44_bii_cell(j)                                 BII (1)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_cost_bv_loss(t,j,type)             Cost of biodiversity loss (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type) Biodiversity stock for all land cover classes (unweighted) (Mha)
 ov44_bii_glo(t,type)                  BII (1)
 ov44_bii_reg(t,i,type)                BII (1)
 ov44_bii_cell(t,j,type)               BII (1)
 oq44_bii_glo(t,type)                  BII (1)
 oq44_bii_reg(t,i,type)                BII (1)
 oq44_bii_cell(t,j,type)               BII (1)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

