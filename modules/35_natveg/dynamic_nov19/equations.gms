*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The interface `vm_land` provides aggregated natveg land pools (`ac`) to other modules.

 q35_land_secdforest(j2) .. vm_land(j2,"secdforest") =e= sum(ac, v35_secdforest(j2,ac));

 q35_land_other(j2) .. vm_land(j2,"other") =e= sum(ac, v35_other(j2,ac));

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
           sum(ac, v35_secdforest(j2,ac)
           *sum(ct, pm_carbon_density_ac(ct,j2,ac,ag_pools)));

 q35_carbon_other(j2,ag_pools)  .. vm_carbon_stock(j2,"other",ag_pools) =e=
           sum(ac, v35_other(j2,ac)
           *sum(ct, pm_carbon_density_ac(ct,j2,ac,ag_pools)));


*' NPI/NDC land protection policies are implemented as minium forest land and other land stock.

 q35_min_forest(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest")
                       =g=
 									     sum(ct, p35_min_forest(ct,j2));

 q35_min_other(j2) .. vm_land(j2,"other") =g= sum(ct, p35_min_other(ct,j2));

*' NPI/NDC land protection policies are combined into one based on minimum land stocks.

 q35_min_natveg(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest") + vm_land(j2,"other")
                      =n=
                      sum(ct, p35_min_forest(ct,j2)) + sum(ct, p35_min_other(ct,j2));

*' The following technical calculations are needed for reducing differences in land-use patterns between time steps.
*' The gross change in natural vegetation is calculated based on land expansion and
*' land contraction of other land, and land reduction of primary and secondary forest.
*' This information is then passed to the land module ([10_land]):

 q35_landdiff .. vm_landdiff_natveg =e=
 					sum((j2,ac),
 							v35_other_expansion(j2,ac)
 						  + v35_other_reduction(j2,ac)
 						  + v35_secdforest_reduction(j2,ac)
 						  + v35_primforest_reduction(j2));

 q35_other_expansion(j2,ac) ..
 	v35_other_expansion(j2,ac) =g=
 		v35_other(j2,ac) - pc35_other(j2,ac);

 q35_other_reduction(j2,ac) ..
 	v35_other_reduction(j2,ac) =g=
 		pc35_other(j2,ac) - v35_other(j2,ac);

 q35_secdforest_reduction(j2,ac) ..
 	v35_secdforest_reduction(j2,ac) =g=
 		pc35_secdforest(j2,ac) - v35_secdforest(j2,ac);

 q35_primforest_reduction(j2) ..
 	v35_primforest_reduction(j2) =g=
 		pcm_land(j2,"primforest") - vm_land(j2,"primforest");

*******************************************************************************
**** Natveg related equations used for production

*' Harvesting costs are paid everytime natural vegetation is harvested. The "real"
*' harvested area are received from the timber module [73_timber].


*' Change in secondary forest compared to previous time step. Helps calculating
*' production coming out of secondary forests.

q35_secdforest_change(j2,ac_sub)..
                           vm_secdforest_reduction(j2,ac_sub)
                           =g=
                           (pc35_secdforest(j2,ac_sub) - v35_secdforest(j2,ac_sub));


*' Change in primary forest compared to previous time step. Helps calculating
*' production coming out of primary forests.

q35_primforest_change(j2)..
                           vm_primforest_reduction(j2)
                           =g=
                           (pcm_land(j2,"primforest") - vm_land(j2,"primforest"));


*' Change in other land compared to previous time step. Helps calculating
*' production of woodfuel coming out of other land.
q35_other_change(j2,ac_sub)..
                          vm_other_reduction(j2,ac_sub)
                          =g=
                          (pc35_other(j2,ac_sub)  - v35_other(j2,ac_sub));


*' Harvested secondary forest is still considered secondary forests due to
*' restrictive NPI definitions. Also primary forest harvested will be considered
*' to be secondary forest.

q35_secdforest_conversion(j2)..
                          v35_secdforest(j2,"ac0")
                          =e=
                          sum(ac_sub,vm_hvarea_secdforest(j2,ac_sub))
                        + vm_hvarea_primforest(j2)
                          ;
