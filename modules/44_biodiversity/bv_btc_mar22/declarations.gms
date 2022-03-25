*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i44_fader(t_all)		Price fader for biodiversity loss price (1)
;

variables
 v44_bii_weighted_diff(j)	 		Change of area- and range-rarity weighted biodiversity intactness index (1)
 vm_cost_bv_loss(j)					Biodiversity cost (mio USD)
;

positive variables
 vm_bv(j,landcover44,potnatveg)		Biodiversity intactness coefficents multiplied with land area (Mha)
 v44_bii(j) 			    		Area-weighted biodiversity intactness index (1)
 v44_bii_weighted(j) 			    Area- and range-rarity weighted biodiversity intactness index (1)
;

equations
 q44_bii(j)		            Area-weighted biodiversity intactness index (1)
 q44_bii_weighted(j)		Area- and range-rarity weighted biodiversity intactness index (1)
 q44_bii_weighted_diff(j)   Change of area- and range-rarity weighted biodiversity intactness index (1)
 q44_cost_bv_loss(j)		Biodiversity cost (mio USD)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov44_bii_weighted_diff(t,j,type)      Change of area- and range-rarity weighted biodiversity intactness index (1)
 ov_cost_bv_loss(t,j,type)             Biodiversity cost (mio USD)
 ov_bv(t,j,landcover44,potnatveg,type) Biodiversity intactness coefficents multiplied with land area (Mha)
 ov44_bii(t,j,type)                    Area-weighted biodiversity intactness index (1)
 ov44_bii_weighted(t,j,type)           Area- and range-rarity weighted biodiversity intactness index (1)
 oq44_bii(t,j,type)                    Area-weighted biodiversity intactness index (1)
 oq44_bii_weighted(t,j,type)           Area- and range-rarity weighted biodiversity intactness index (1)
 oq44_bii_weighted_diff(t,j,type)      Change of area- and range-rarity weighted biodiversity intactness index (1)
 oq44_cost_bv_loss(t,j,type)           Biodiversity cost (mio USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

