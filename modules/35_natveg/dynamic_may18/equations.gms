*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The interface `vm_land` provides aggregated natveg land pools (`land35`) to other modules.

 q35_land_secdforest(j2) .. vm_land(j2,"secdforest") =e= sum(land35, v35_secdforest(j2,land35));

 q35_land_other(j2) .. vm_land(j2,"other") =e= sum(land35, v35_other(j2,land35));

*' Carbon stocks for primary forest, secondary forest or other natural land are calculated
*' as the product of respective area and carbon density.
*' Carbon stocks decline if the area decreases
*' (e.g. due to cropland expansion into forests).
*' In case of abandoned agricultural land (increase of other natural land),
*' natural succession, represented by age-class growth, results in increasing carbon stocks.

 q35_carbon_primforest(j2,ag_pools) .. vm_carbon_stock(j2,"primforest",ag_pools) =e=
           vm_land(j2,"primforest")
           *sum(ct, fm_carbon_density(ct,j2,"primforest",ag_pools));

 q35_carbon_secdforest(j2,ag_pools) .. vm_carbon_stock(j2,"secdforest",ag_pools) =e=
           sum(land35, v35_secdforest(j2,land35)
           *sum(ct, p35_carbon_density_secdforest(ct,j2,land35,ag_pools)));

 q35_carbon_other(j2,ag_pools)  .. vm_carbon_stock(j2,"other",ag_pools) =e=
           sum(land35, v35_other(j2,land35)
           *sum(ct, p35_carbon_density_other(ct,j2,land35,ag_pools)));


*' NPI/NDC land protection policies are implemented as minium forest land and other land stock.

 q35_min_forest(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest") =g=
 									sum(ct, p35_min_forest(ct,j2));

 q35_min_other(j2) .. vm_land(j2,"other") =g= sum(ct, p35_min_other(ct,j2));

*' The following technical calculations are needed for reducing differences in land-use patterns between time steps.
*' The gross change in natural vegetation is calculated based on land expansion and
*' land contraction of other land, and land reduction of primary and secondary forest.
*' This information is then passed to the land module ([10_land]):

 q35_landdiff .. vm_landdiff_natveg =e=
 					sum((j2,land35),
 							v35_other_expansion(j2,land35)
 						  + v35_other_reduction(j2,land35)
 						  + v35_secdforest_reduction(j2,land35)
 						  + v35_primforest_reduction(j2));

 q35_other_expansion(j2,land35) ..
 	v35_other_expansion(j2,land35) =g=
 		v35_other(j2,land35) - pc35_other(j2,land35);

 q35_other_reduction(j2,land35) ..
 	v35_other_reduction(j2,land35) =g=
 		pc35_other(j2,land35) - v35_other(j2,land35);

 q35_secdforest_reduction(j2,land35) ..
 	v35_secdforest_reduction(j2,land35) =g=
 		pc35_secdforest(j2,land35) - v35_secdforest(j2,land35);

 q35_primforest_reduction(j2) ..
 	v35_primforest_reduction(j2) =g=
 		pcm_land(j2,"primforest") - vm_land(j2,"primforest");
