*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Land constraints. Aggregation of detailed land pools (`land35`).

 q35_land_secdforest(j2) .. vm_land(j2,"secdforest") =e= sum(land35, v35_secdforest(j2,land35));

 q35_land_other(j2) .. vm_land(j2,"other") =e= sum(land35, v35_other(j2,land35));

*' Carbon stock calculations for primary forest, secondary forest or other natural land.
*' We calculate carbon stocks as product of area and carbon density.
*' Therefore, carbon stocks decline if the area decreases
*' (e.g. due to cropland expansion into forests).
*' In case of abandoned agricultural land (increase of other natural land),
*' we model natural succession by age-class growth, which results in increasing carbon stocks.

 q35_carbon_primforest(j2,c_pools) .. vm_carbon_stock(j2,"primforest",c_pools) =e=
           vm_land(j2,"primforest")
           *sum(ct, fm_carbon_density(ct,j2,"primforest",c_pools));

 q35_carbon_secdforest(j2,c_pools) .. vm_carbon_stock(j2,"secdforest",c_pools) =e=
           sum(land35, v35_secdforest(j2,land35)
           *sum(ct, p35_carbon_density_secdforest(ct,j2,land35,c_pools)));

 q35_carbon_other(j2,c_pools)  .. vm_carbon_stock(j2,"other",c_pools) =e=
           sum(land35, v35_other(j2,land35)
           *sum(ct, p35_carbon_density_other(ct,j2,land35,c_pools)));


*' NPI/NDC policies: Avoided deforestation, and CO2 emissions from the conversion of primary
*' and secondary forest. Afforestation NPI/NDC policies are accounted for in the
*' [32_forestry] module.
*' NPI/NDC policies are ramped up until 2030, and are assumed constant thereafter.
*' If a country has plans for afforestation (according to it's NDC documents),
*' we assume a stop of deforestation.
*' CO2 emission reduction targets apply on CO2 emissions from the conversion of
*' primary forest, secondary forest and other natural land.


 q35_min_forest(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest") =g=
 									sum(ct, p35_min_forest(ct,j2));

 q35_min_other(j2) .. vm_land(j2,"other") =g= sum(ct, p35_min_other(ct,j2));


*' @stop
*' Technical calculations needed for reducing differences in land-use patterns between time steps

*' The gross changes in natural vegetation is calculated based on land expansion and
*' land contraction of other land and land reduction of primary and secondary forest
*' this information is then passed to the land module ([10_land]):

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
