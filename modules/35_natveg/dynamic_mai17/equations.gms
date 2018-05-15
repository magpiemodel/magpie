*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Aggregation of detailed land pools
 q35_land_secdforest(j2) .. vm_land(j2,"secdforest") =e= sum(land35, v35_secdforest(j2,land35));

 q35_land_other(j2) .. vm_land(j2,"other") =e= sum(land35, v35_other(j2,land35));

*' Carbon stock calculations
 q35_carbon_primforest(j2,c_pools) .. vm_carbon_stock(j2,"primforest",c_pools) =e=
           vm_land(j2,"primforest")*sum(ct, fm_carbon_density(ct,j2,"primforest",c_pools));

 q35_carbon_secdforest(j2,c_pools) .. vm_carbon_stock(j2,"secdforest",c_pools) =e=
           sum(land35, v35_secdforest(j2,land35)*sum(ct, p35_carbon_density_secdforest(ct,j2,land35,c_pools)));

 q35_carbon_other(j2,c_pools)  .. vm_carbon_stock(j2,"other",c_pools) =e=
           sum(land35, v35_other(j2,land35)*sum(ct, p35_carbon_density_other(ct,j2,land35,c_pools)));


*' NPI/NDC policies
 q35_min_forest(j2) .. vm_land(j2,"primforest") + vm_land(j2,"secdforest") =g= sum(ct, p35_min_forest(ct,j2));

 q35_min_cstock(j2) .. sum(c_pools, vm_carbon_stock(j2,"primforest",c_pools) + vm_carbon_stock(j2,"secdforest",c_pools)) =g= 
 						sum(ct, p35_min_cstock(ct,j2));

*' Technical calculations
 q35_diff .. vm_landdiff_natveg =e= sum(j2, v35_other(j2,"new")
                                          + v35_secdforest(j2,"new")
                                          + pcm_land(j2,"primforest")
                                          + pcm_land(j2,"secdforest")
                                          + pcm_land(j2,"other")
                                          - vm_land(j2,"primforest")
                                          - v35_secdforest(j2,"grow")
                                          - v35_secdforest(j2,"old")
                                          - v35_other(j2,"grow")
                                          - v35_other(j2,"old"));
