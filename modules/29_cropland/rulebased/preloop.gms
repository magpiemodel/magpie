*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_fallow.fx(j) = 0;

** Trajectory for cropland scenarios
* sigmoidal interpolation between start year and target year
m_sigmoid_time_interpol(p29_snv_scenario_fader,s29_snv_scenario_start,s29_snv_scenario_target,0,1);
m_sigmoid_time_interpol(p29_rotation_scenario_fader,s29_rotation_scenario_start,s29_rotation_scenario_target,0,1);

* linear interpolation to estimate the cropland that
* requires relocation due to SNV policy
if (s29_snv_shr = 0,
i29_snv_relocation_target(j) = 0;

elseif s29_snv_shr <= s29_snv_relocation_data_x1,
m_linear_cell_data_interpol(i29_snv_relocation_target, s29_snv_shr,0,s29_snv_relocation_data_x1,0, f29_snv_target_cropland(j, "SNV20TargetCropland"));

elseif s29_snv_shr > s29_snv_relocation_data_x1,
m_linear_cell_data_interpol(i29_snv_relocation_target, s29_snv_shr,s29_snv_relocation_data_x1, s29_snv_relocation_data_x2,f29_snv_target_cropland(j, "SNV20TargetCropland"), f29_snv_target_cropland(j, "SNV50TargetCropland"));
);


m_sigmoid_time_interpol(p29_treecover_scenario_fader,s29_treecover_scenario_start,s29_treecover_scenario_target,0,1);
m_sigmoid_time_interpol(p29_betr_scenario_fader,s29_betr_scenario_start,s29_betr_scenario_target,0,1);

* Initial tree cover on cropland is assumed to be equally distributed among all age-classes
pc29_treecover(j,ac) = 0;
pc29_treecover(j,ac)$(pm_land_hist("y2015",j,"crop") > 1e-10) = 
 (f29_treecover(j) / pm_land_hist("y2015",j,"crop") * pm_land_hist("y1995",j,"crop")) / card(ac);


*' Switch for tree cover on cropland:
*' 0 = Use natveg growth curve towards LPJmL natural vegetation
*' 1 = Use plantation growth curve (faster than natveg) towards LPJmL natural vegetation
if(s29_treecover_plantation = 0,
 p29_carbon_density_ac(t,j,ac,ag_pools) = pm_carbon_density_ac(t,j,ac,ag_pools);
elseif s29_treecover_plantation = 1,
 p29_carbon_density_ac(t,j,ac,ag_pools) = pm_carbon_density_ac_forestry(t,j,ac,ag_pools);
);

** set bii coefficients
p29_treecover_bii_coeff(bii_class_secd,potnatveg) = 0;
if(s29_treecover_bii_coeff = 0,
 p29_treecover_bii_coeff(bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg)
elseif s29_treecover_bii_coeff = 1,
 p29_treecover_bii_coeff(bii_class_secd,potnatveg) = fm_bii_coeff("timber",potnatveg)
);
