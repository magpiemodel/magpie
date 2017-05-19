*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

q33_land(j2,si) .. vm_land(j2,"forest",si) =e=
           sum(land33, v33_land(j2,land33,si));

q33_carbon(j2,c_pools) .. vm_carbon_stock(j2,"forest",c_pools) =e=
           sum(land33, sum(si, v33_land(j2,land33,si))*pc33_carbon_density(j2,land33,c_pools));

q33_diff .. vm_landdiff_forest =e= sum((j2,si), pcm_land(j2,"forest",si)
                                          - v33_land(j2,"modnat",si)
                                          - v33_land(j2,"ifft",si));

q33_defor(i2) .. sum((cell(i2,j2),si), pcm_land(j2,"forest",si)-vm_land(j2,"forest",si)) =l=
                                sum(ct, p33_max_deforest(ct,i2))*m_timestep_length;
