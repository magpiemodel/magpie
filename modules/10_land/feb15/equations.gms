*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 q10_landexpansion(j2,land,si) ..
        vm_landexpansion(j2,land,si) =g= vm_land(j2,land,si)-pcm_land(j2,land,si);

 q10_landreduction(j2,land,si) ..
        vm_landreduction(j2,land,si) =g= pcm_land(j2,land,si)-vm_land(j2,land,si);

 q10_landdiff .. vm_landdiff =e= sum((j2,land,si), vm_landexpansion(j2,land,si)
                                                + vm_landreduction(j2,land,si))
                                 + vm_landdiff_other
                                 + vm_landdiff_forest
                                 + vm_landdiff_forestry;


 q10_land(j2,si) .. sum(land, vm_land(j2,land,si))
                   =e=
                   sum(land, pcm_land(j2,land,si));

 q10_lu_miti(j2) .. sum(w, vm_area(j2,"begr",w) + vm_area(j2,"betr",w)) +
                                            sum(si, vm_land(j2,"forestry",si) - f10_land(j2,"forestry",si))
                           =l=
                           s10_lu_miti_shr*sum((land,si), pcm_land(j2,land,si));
