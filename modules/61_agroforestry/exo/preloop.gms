*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

m_sigmoid_time_interpol(p61_treecover_scenario_fader,s61_treecover_scenario_start,s61_treecover_scenario_target,0,1);
m_sigmoid_time_interpol(p61_betr_scenario_fader,s61_betr_scenario_start,s61_betr_scenario_target,0,1);

* Initial tree cover on cropland is assumed to be equally distributed among all age-classes
pc61_treecover(j,ac) = (pm_treecover_shr(j)*pm_land_start(j,"crop"))/card(ac);
  
*' Switch for tree cover on cropland:
*' 0 = Use natveg growth curve towards LPJmL natural vegetation
*' 1 = Use plantation growth curve (faster than natveg) towards LPJmL natural vegetation
if(s61_treecover_plantation = 0,
 p61_carbon_density_ac(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
elseif s61_treecover_plantation = 1,
 p61_carbon_density_ac(t,j,ac,ag_pools) = pm_carbon_density_ac_forestry(t,j,ac,ag_pools);
);

** set bii coefficients
p61_treecover_bii_coeff(bii_class_secd,potnatveg) = 0;
if(s61_treecover_bii_coeff = 0,
 p61_treecover_bii_coeff(bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg)
elseif s61_treecover_bii_coeff = 1,
 p61_treecover_bii_coeff(bii_class_secd,potnatveg) = fm_bii_coeff("timber",potnatveg)
);
