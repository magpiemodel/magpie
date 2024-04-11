*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' For the time period beloning to the historical time period (y1965 to y2010
*' in this version of the model), the scalar `s62_historical` is set to 1 and
*' for the non-historical time periods, `s62_historical` is set to 0.
*' How this switch affects the material demand calculations is explained in the
*' equation(s) accompanying this module.

if (sum(sameas(t_past,t),1) = 1,
  s62_historical=1;
else
 s62_historical=0;
);

p62_scaling_factor(i) = 1;
p62_scaling_factor(i)$(p62_dem_food_lastcalibyear(i) > 0) = sum(kfo, vm_dem_food.l(i,kfo)) / p62_dem_food_lastcalibyear(i);

*' @stop

* In t_past, biomass demand for bioplastic is already included in the general material demand, which is 
* scaled for future years. Therefore we calculate the amount of biomass that is counted twice, and subtract
* it in the final biomass demand equation. 
if (sum(sameas(t_past,t),1) = 1,
  p62_bioplastic_substrate_double_counted(t,i,kall) = p62_bioplastic_substrate(t,i,kall);
  p62_bioplastic_substrate_lastcalibyear(i,kall) = p62_bioplastic_substrate(t,i,kall);
else
  p62_bioplastic_substrate_double_counted(t,i,kall) = p62_bioplastic_substrate_lastcalibyear(i,kall) * p62_scaling_factor(i);
);
