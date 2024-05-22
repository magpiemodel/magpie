*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*age-class carbon density start values
pc52_carbon_density_start(t_all,j,"vegc") = 0;
pc52_carbon_density_start(t_all,j,"litc") = fm_carbon_density(t_all,j,"past","litc");

* ----------------------------
* Forestry
* ----------------------------

*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_plantation_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"secdforest","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","plantations")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","plantations")),(ord(ac)-1));

*calculate litter carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_plantation_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"secdforest","litc"),(ord(ac)-1));

* -----------------------------
* Natveg
* -----------------------------

*** Secondary forest
*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_secdforest_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"secdforest","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","natveg")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","natveg")),(ord(ac)-1));

*calculate litter carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_secdforest_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"secdforest","litc"),(ord(ac)-1));

*** Other land
*calculate vegetation age-class carbon density in current time step with chapman richards equation
pm_carbon_density_other_ac(t_all,j,ac,"vegc") = m_growth_vegc(pc52_carbon_density_start(t_all,j,"vegc"),fm_carbon_density(t_all,j,"other","vegc"),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"k","natveg")),sum(clcl,pm_climate_class(j,clcl)*f52_growth_par(clcl,"m","natveg")),(ord(ac)-1));

*calculate litter carbon density based on linear growth funktion: carbon_density(ac) = intercept + slope*ac (20 year time horizon taken from IPCC)
pm_carbon_density_other_ac(t_all,j,ac,"litc") = m_growth_litc_soilc(pc52_carbon_density_start(t_all,j,"litc"),fm_carbon_density(t_all,j,"other","litc"),(ord(ac)-1));
