*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*'
*' The bioenergy demand calculation for second generation bioenergy is based on
*' the following two equations from which always only one is active:
*' If $c60\_biodem\_level$ is 1 (regional) the right hand side of the first equation
*' is set to 0, if it is 0 (global) the right hand side of the second equation
*' is set to 0.

q60_bioenergy_glo.. sum((kbe60,i2), vm_dem_bioen(i2,kbe60)*fm_attributes("ge",kbe60))
          =g= sum((ct,i2),i60_bioenergy_dem(ct,i2))*(1-c60_biodem_level);

q60_bioenergy_reg(i2).. sum(kbe60, vm_dem_bioen(i2,kbe60)*fm_attributes("ge",kbe60))
          =g= sum(ct,i60_bioenergy_dem(ct,i2))*c60_biodem_level;

*' Except the implementation of the switches and the fact that in the first
*' equation the bioenergy demand is summed up to a global demand both equations
*' act the same way: In both cases the equation just makes sure that the sum
*' over all second generation energy crop of the bioenergy demand is greater or
*' equal to the demand actually given by the input file $i60\_bioenergy\_dem$.

q60_res_2ndgenBE(i2) .. 
  sum(kres, vm_dem_bioen(i2,kres) * fm_attributes("ge",kres)
            - sum(ct,f60_1stgen_bioenergy_dem(ct,i2,"%c60_1stgen_biodem%",kres))) =g= 
  sum(ct,i60_res_2ndgenBE_dem(ct,i2));
  
*' There is additionally some demand of residues for second generation bioenergy 
*' $i60\_res\_2ndgenBE\_dem$, which is exogenously provided by the estimation that 
*' roughly 33% of available residues for recycling on cropland can be used for 2nd 
*' generation bioenergy depending on the SSP scenario, since residue stock and use 
*' is mainly driven by population and GDP.
 