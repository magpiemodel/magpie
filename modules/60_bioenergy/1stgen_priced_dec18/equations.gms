*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Total demand for bioenergy comes from different origins
*' 1st generation bioenergy demand is a fixed trajectory of minimum production
*' requirements. Second generation bioenergy splits into a Demand
*' for dedicated bioenergy crops, which are fully substitutable based on their
*' energy content, and residues which are also fully substitutable based on
*' their energy content.

q60_bioenergy(i2,kall) ..
      vm_dem_bioen(i2,kall) * fm_attributes("ge",kall) =g=
      sum(ct, i60_1stgen_bioenergy_dem(ct,i2,kall)) +
      v60_2ndgen_bioenergy_dem_dedicated(i2,kall) +
      v60_2ndgen_bioenergy_dem_residues(i2,kall)
      ;

*' The used first generation bioenergy trajectory contains demand until 2050
*' based on currently established and planned bioenergy policies
*' (@lotze-campen_impacts_2014). For the time
*' after 2050 it is assumed that bioenergy production will be fully transformed
*' to 2nd generation bioenergy crops and residues because of their higher
*' estimated efficiency respectively their low costs.
*'
*' For second generation bioenergy from dedicated bioenergy crops
*' (`kbe60` = bioenergy grasses and bioenergy
*' trees), input is given either on regional or global level (defined via switch
*' $c60\_biodem\_level$). As the bioenergy demand for all crop types was fixed in the
*' first step it now has to be released again for second generation bioenergy
*' crops (`kbe60`).
*'
*' The bioenergy demand calculation for second generation bioenergy is based on
*' the following two equations from which always only one is active:
*' If $c60\_biodem\_level$ is 1 (regional) the right hand side of the first equation
*' is set to 0, if it is 0 (global) the right hand side of the second equation
*' is set to 0.

q60_bioenergy_glo.. sum((kbe60,i2), v60_2ndgen_bioenergy_dem_dedicated(i2,kbe60))
                    =g= sum((ct,i2),i60_bioenergy_dem(ct,i2))*(1-c60_biodem_level);

q60_bioenergy_reg(i2).. sum(kbe60, v60_2ndgen_bioenergy_dem_dedicated(i2,kbe60))
                    =g= sum(ct,i60_bioenergy_dem(ct,i2))*c60_biodem_level;

*' Except the implementation of the switches and the fact that in the first
*' equation the bioenergy demand is summed up to a global demand both equations
*' act the same way: In both cases the equation just makes sure that the sum
*' over all second generation energy crop of the bioenergy demand is greater or
*' equal to the demand actually given by the input file $i60\_bioenergy\_dem$.

*' There is additionally some demand of residues for second generation bioenergy
*' $i60\_res\_2ndgenBE\_dem$, which is exogenously provided by the estimation that
*' roughly 33% of available residues for recycling on cropland can be used for 2nd
*' generation bioenergy depending on the SSP scenario, since residue stock and use
*' is mainly driven by population and GDP.

q60_res_2ndgenBE(i2) ..
  sum(kres, v60_2ndgen_bioenergy_dem_residues(i2,kres))
  =g=
  sum(ct,i60_res_2ndgenBE_dem(ct,i2));

*' Finally, an incentive is provided for the production of 1st generation
*' bioenergy from oils and ethanol even beyond the exogeneous minimum demand.
*' The incentive is kept low, but should provide a more realistic
*' overproduction from couple products.

q60_bioenergy_incentive(i2).. vm_bioenergy_utility(i2)
          =e= sum(k1st60, vm_dem_bioen(i2,k1st60) * (-c60_bioenergy_subsidy));
