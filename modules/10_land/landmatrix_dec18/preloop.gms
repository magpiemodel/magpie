*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
pm_land_start(j,land) = f10_land("y1995",j,land);
pm_land_start(j,land)$(pm_land_start(j,land)<0) = 0;

pcm_land(j,land) = pm_land_start(j,land);
vm_land.l(j,land) = pcm_land(j,land);

*Ratio of plantation area development in historical period used for timber plantations
*establishment decisions in the current steps

*Initialize value with 1
pm_forestry_land_ratio(t_ext,i) = 1;
loop (t_ini10$(ord(t_ini10)>1),
 pm_forestry_land_ratio(t_ini10,i) = (sum(cell(i,j),f10_land(t_ini10,j,"forestry"))/sum(cell(i,j),f10_land(t_ini10-1,j,"forestry")));
);
*Overwrite first time period value with 2nd year of simulation
pm_forestry_land_ratio(t_ini10,i)$(ord(t_ini10)=1)                = pm_forestry_land_ratio(t_ini10+1,i);
