*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q33_carbon_primforest(j2,c_pools) .. vm_carbon_stock(j2,"primforest",c_pools) =e=
           vm_land(j2,"primforest")*sum(ct,fm_carbon_density(ct,j2,"primforest",c_pools));

q33_carbon_secdforest(j2,c_pools) .. vm_carbon_stock(j2,"secdforest",c_pools) =e=
           vm_land(j2,"secdforest")*sum(ct,p33_carbon_density(ct,j2,c_pools));

q33_diff .. vm_landdiff_forest =e= sum((j2), pcm_land(j2,"primforest")
										  + pcm_land(j2,"secdforest")
                                          - vm_land(j2,"primforest")
                                          - vm_land(j2,"secdforest"));
