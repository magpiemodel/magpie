*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The Biodiversity Intactness Index (BII) is calculated at cell level

 q44_bii(j2)$(sum(biome44, f44_biome(j2,biome44)) > 0) .. v44_bii(j2)
 					=e=
 					(sum((biome44,potnatveg,landcover44), vm_bv(j2,landcover44,potnatveg) * f44_biome(j2,biome44)) / sum((biome44,land), pcm_land(j2,land) * f44_biome(j2,biome44)));

*' For each cell, the BII has to meet a minium level based on `s44_bii_lower_bound`.
*' `v44_bii_missing` is a technical variable to maintain feasibility in case `v44_bii` cannot be increased.
 					
 q44_bii_target(j2)$(sum(biome44, f44_biome(j2,biome44)) > 0) .. 					
 					v44_bii(j2) + v44_bii_missing(j2) =g= sum(ct, p44_bii_lower_bound(ct,j2));

*' Costs accrue only for `v44_bii_missing`. In the best case costs should be zero or close to zero.
*' Costs strongly depend on the choice of `s44_bii_lower_bound`.

 q44_cost ..	sum(j2, vm_cost_bv_loss(j2)) =e= 
					sum(j2, v44_bii_missing(j2)) * s44_cost_bii_missing;

