*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q60_bioenergy_glo.. sum((kbe60,i2), vm_dem_bioen(i2,kbe60)*fm_attributes("ge",kbe60))
          =g= sum((ct,i2),i60_bioenergy_dem(ct,i2))*sm_use_bioenergy*(1-c60_biodem_level);

q60_bioenergy_reg(i2).. sum(kbe60, vm_dem_bioen(i2,kbe60)*fm_attributes("ge",kbe60))
          =g= sum(ct,i60_bioenergy_dem(ct,i2))*sm_use_bioenergy*c60_biodem_level;

q60_1st_bioenergy(i2).. sum(kcr,vm_dem_bioen(i2,kcr)*fm_attributes("ge",kcr)*v60_convexhull(i2,kcr))
          =g= sum(ct,f60_dem_1stgen_bioen(ct,i2,"%c60_1stgen_biodem%"))*sm_use_bioenergy*c60_biodem_level;

q60_1st_bioenergy_convexhull(i2)..sum(kcr,v60_convexhull(i2,kcr)) =e= 1;