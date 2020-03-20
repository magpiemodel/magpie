*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_dem_bioen.fx(i2,kap)=0;

if(m_year(t) <= 2015,
 i60_res_2ndgenBE_dem(t,i) =
             f60_res_2ndgenBE_dem(t,i,"ssp2");
else 
 i60_res_2ndgenBE_dem(t,i) =
             f60_res_2ndgenBE_dem(t,i,"%c60_res_2ndgenBE_dem%");
);
