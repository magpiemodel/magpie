*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 q35_land(j2,si) .. vm_land(j2,"other",si) =e=
                         sum(land35, v35_land(j2,land35,si));

 q35_carbon(j2,c_pools)  .. vm_carbon_stock(j2,"other",c_pools) =e=
                        sum(land35, sum(si, v35_land(j2,land35,si))*pc35_carbon_density(j2,land35,c_pools));


 q35_diff .. vm_landdiff_other =e= sum((j2,si),v35_land(j2,"new",si)
                                          + pcm_land(j2,"other",si)
                                          - v35_land(j2,"old",si)
                                          - v35_land(j2,"grow",si));
