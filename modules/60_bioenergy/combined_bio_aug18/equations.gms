*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


q60_bioenergy_glo.. sum(i2, sum(kbe60,   vm_dem_bioen(i2, kbe60)*f60_energyfactor(kbe60)))
          =g= sum((ct,i2),i60_bioenergy_dem(ct,i2))*(1-c60_biodem_level);



q60_bioenergy_reg(i2).. sum(kbe60, vm_dem_bioen(i2,kbe60)*f60_energyfactor(kbe60))
          =g= sum(ct,i60_bioenergy_dem(ct,i2))*c60_biodem_level;
