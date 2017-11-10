*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

  
q60_bioenergy_glo.. sum((ksd,kpr,i2), vm_bioenergy_specialized(i2,ksd,kpr)*fm_attributes("ge",ksd))
          =g= sum((ct,i2),i60_bioenergy_dem(ct,i2))*(1-c60_biodem_level);

q60_bioenergy_reg(i2).. sum((ksd,kpr), vm_bioenergy_specialized(i2,ksd,kpr)*fm_attributes("ge",ksd))
          =g= sum(ct,i60_bioenergy_dem(ct,i2))*c60_biodem_level;
		  
q60_bioenergy_sum_glo(kall).. vm_dem_bioen(kall)*(1-c60_biodem_level)
          =e= sum(i2, f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",kall)/fm_attributes("ge",kall)
              + vm_bioenergy_specialized(i2,ksd,kpr))*(1-c60_biodem_level);		

q60_bioenergy_sum_reg(i2, kall).. vm_dem_bioen(i2,kall)*c60_biodem_level
          =e= f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",kall)/fm_attributes("ge",kall)
              + vm_bioenergy_specialized(i2,ksd,kpr)*c60_biodem_level;
			  
