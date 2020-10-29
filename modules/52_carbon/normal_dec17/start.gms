*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*age-class carbon density start values
pc52_carbon_density_start(t_all,j,"vegc") = 0;
pc52_carbon_density_start(t_all,j,"litc") = fm_carbon_density(t_all,j,"past","litc");

*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_ac_forestry(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","plantations")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","plantations")),(ord(ac)-1));

*Creating a scaling factor for carbon densities which are lower than the threshold. This will
*hlep upscale these numbers in later stage. We compare the maximum stable carbon density from LPJmL
*with the threshold.

*Initialize the scalaing factor as 1
p52_scaling_factor(t_all,j) = 1;

*Update scaling factor for every cell where carbon density is greater than 0 to avoid division bx zero error
*This also makes sure that there are always reasonable numbers in zero carbon density cells
p52_scaling_factor(t_all,j)$(pm_carbon_density_ac_forestry(t_all,j,"acx","vegc")>0) = s52_plantation_threshold/pm_carbon_density_ac_forestry(t_all,j,"acx","vegc");
*Cells with zero carbon density would have to use the maximum threshold number for bringing the yields up to plantation levels.
p52_scaling_factor(t_all,j)$(pm_carbon_density_ac_forestry(t_all,j,"acx","vegc")=0) = s52_plantation_threshold;

*Comparison above would yield values lower than 1 when LPJmL carbon densities are higher than threshold.
p52_scaling_factor(t_all,j)$(p52_scaling_factor(t_all,j) <= 1) = 1;

* Creating a layer where if carbon densities received from LPJmL are greater than a threshold then the model does
* Not have to invest extra in setting up plantations in those cells but if the model uses updated carbon densities
* in cells where LPJmL yields were lower than the threshold then it will remove granularity from the options available
* to the model for making establishment decisions. This layer makes sure that such granularity is preserved and model
* still has access to the information about how low were the yields compared to the threshold. A penalty component is then
* added in forestry module to make sure that the model does not use extremely unproductive cells for establishment decisions.
pm_investment_layer(t_all,j)$(p52_scaling_factor(t_all,j) <= 1) = 0;
pm_investment_layer(t_all,j)$(p52_scaling_factor(t_all,j) > 1) = s52_plantation_threshold - pm_carbon_density_ac_forestry(t_all,j,"acx","vegc");

* Certain cells have quite low carbon density and with a lower rotation length, it is not possioble to produce
* any reasonable amount of thimber. This has impact on timber yield calculations. With higher carbon densities
* in cells below a threshold, the stable carbon density is updated and new growth curve is obtained.
* This is specially applicable for middle east region where LPJmL reports quite low carbon densities. Provided the
* wood production data from FAO, it is not possible to replicate past production patterns in middle east region
* with such low carbon densities and yield.
pm_carbon_density_ac_forestry(t_all,j,ac,"vegc") = pm_carbon_density_ac_forestry(t_all,j,ac,"vegc") * p52_scaling_factor(t_all,j);

*calculate litter and soil carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_ac_forestry(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"other","litc"),(ord(ac)-1));

*** EOF pre.gms ***
