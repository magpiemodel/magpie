*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 q35_land(j2) .. vm_land(j2,"other") =e=
                         sum(land35, v35_land(j2,land35));

 q35_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"other",c_pools) =e=
                        sum(land35, v35_land(j2,land35)*pc35_carbon_density(j2,land35,c_pools));


 q35_diff .. vm_landdiff_other =e= sum((j2),v35_land(j2,"new")
                                          + pcm_land(j2,"other")
                                          - v35_land(j2,"old")
                                          - v35_land(j2,"grow"));
