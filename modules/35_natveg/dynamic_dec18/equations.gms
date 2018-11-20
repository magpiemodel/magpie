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

 q35_carbon_primforest(j2,c_pools) .. vm_carbon_stock(j2,"primforest",c_pools) =e=
           vm_land(j2,"primforest")
           *sum(ct, fm_carbon_density(ct,j2,"primforest",c_pools));

 q35_carbon_secdforest(j2,c_pools) .. vm_carbon_stock(j2,"secdforest",c_pools) =e=
           sum(ac, v35_secdforest(j2,ac)
           *sum(ct, pm_carbon_density_ac(ct,j2,ac,c_pools)));

 q35_carbon_other(j2,c_pools)  .. vm_carbon_stock(j2,"other",c_pools) =e=
           sum(ac, v35_other(j2,ac)
           *sum(ct, pm_carbon_density_ac(ct,j2,ac,c_pools)));


*' NPI/NDC land protection policies are implemented as minium forest land and other land stock.

 q35_min_forest(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest") =g=
 									sum(ct, p35_min_forest(ct,j2));

 q35_min_other(j2) .. vm_land(j2,"other") =g= sum(ct, p35_min_other(ct,j2));

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
** Natveg related production costs
q35_cost_total(i2) .. vm_cost_natveg(i2) =e=
                     v35_cost_harvest(i2)
								   + sum((cell(i2,j2),kforestry), v35_prod_external(j2,kforestry) * 99999)
								   ;
*******************************************************************************
**** Cost of harvesting from NatVeg
q35_cost_harvest(i2)..
                    v35_cost_harvest(i2)
                    =e=
                    sum((cell(i2,j2), kforestry),
                    sum(ac_sub, v35_hvarea_secdforest(j2,kforestry,ac_sub))
                  + sum(ac_sub, v35_hvarea_other(j2,"woodfuel",ac_sub))
                  + v35_hvarea_primforest(j2,kforestry)) * fm_harvest_cost_ha(i2)
                    ;

*******************************************************************************
*******************************************************************************
**** Production equations from NatVeg

**** From Secondary forest
q35_prod_secdforest_wood(j2)..
                         v35_prod(j2,"secdforest","wood")
                          =e=
						             sum(ac_sub, v35_hvarea_secdforest(j2,"wood",ac_sub) * sum(ct, p35_yield_natveg(ct,j2,ac_sub)))* 0.80;

q35_prod_secdforest_woodfuel(j2)..
                          v35_prod(j2,"secdforest","woodfuel")
                          =e=
                          sum(ac_sub, v35_hvarea_secdforest(j2,"wood",ac_sub)	    * sum(ct, p35_yield_natveg(ct,j2,ac_sub)))* (1-0.80)
	   				            + sum(ac_sub, v35_hvarea_secdforest(j2,"woodfuel",ac_sub)	* sum(ct, p35_yield_natveg(ct,j2,ac_sub)));


**** From Primary forest
q35_prod_primforest_wood(j2)..
                          v35_prod(j2,"primforest","wood")
                          =e=
                          v35_hvarea_primforest(j2,"wood") * sum(ct, p35_yield_primforest(ct,j2))* 0.70;

q35_prod_primforest_woodfuel(j2)..
                          v35_prod(j2,"primforest","woodfuel")
                          =e=
                          v35_hvarea_primforest(j2,"wood")      * sum(ct, p35_yield_primforest(ct,j2)) * (1-0.70)
                         +v35_hvarea_primforest(j2,"woodfuel")  * sum(ct, p35_yield_primforest(ct,j2));

**** From other land (only woodfuel)
q35_prod_other(j2)..
                          v35_prod(j2,"other","woodfuel")
                          =e=
                          sum(ac_sub,v35_hvarea_other(j2,"woodfuel",ac_sub) * sum(ct, p35_yield_natveg(ct,j2,ac_sub)));

*******************************************************************************
*******************************************************************************
**** Harvested area calculations

q35_hvarea_secdforest(j2,ac_sub)..
                          sum(kforestry,v35_hvarea_secdforest(j2,kforestry,ac_sub))
                          =l=
                          (pc35_secdforest(j2,ac_sub) - v35_secdforest(j2,ac_sub));

q35_hvarea_primforest(j2)..
                          sum(kforestry,v35_hvarea_primforest(j2,kforestry))
                          =l=
                          (pcm_land(j2,"primforest") - vm_land(j2,"primforest"));

q35_hvarea_other(j2,ac_sub)..
                          sum(kforestry,v35_hvarea_other(j2,kforestry,ac_sub))
                          =l=
                          (pc35_other(j2,ac_sub)  - v35_other(j2,ac_sub));

**--------------------------------------------------------------------
q35_secdforest_conversion(j2)..
                          v35_secdforest(j2,"ac0")
                          =e=
                          sum((kforestry,ac_sub),v35_hvarea_secdforest(j2,kforestry,ac_sub))
                        + sum(kforestry,v35_hvarea_primforest(j2,kforestry))
                          ;
********** NatVeg production of timber
q35_production_timber(i2)..
                          sum((kforestry,cell(i2,j2)),vm_prod(j2,kforestry)) * (1-pcm_production_ratio_future(i2))
                          =g=
                          sum((kforestry,cell(i2,j2)),sum(land_natveg, v35_prod(j2,land_natveg,kforestry)) + v35_prod_external(j2,kforestry))
                          ;
