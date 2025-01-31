*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Trajectory for cropland scenarios
* sigmoidal interpolation between start year and target year
m_sigmoid_time_interpol(i30_rotation_scenario_fader,s30_rotation_scenario_start,s30_rotation_scenario_target,0,1);
m_sigmoid_time_interpol(i30_betr_scenario_fader,s30_betr_scenario_start,s30_betr_scenario_target,0,1);

*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
fm_croparea(t_past,j,w,kcr)$(fm_croparea(t_past,j,w,kcr)<0) = 0;

* Country switch to determine countries for which certain policies shall be applied.
* In the default case, the policy affects all countries when activated.
p30_country_switch(iso) = 0;
p30_country_switch(policy_countries30) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by available cropland area.
p30_country_weight(i) = sum(i_to_iso(i,iso), p30_country_switch(iso) * pm_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), pm_avl_cropland_iso(iso));

* Initialize biodiversity value
vm_bv.l(j,"crop_ann",potnatveg) =
  sum((crop_ann30,w), fm_croparea("y1995",j,w,crop_ann30)) * fm_bii_coeff("crop_ann",potnatveg) 
  * fm_luh2_side_layers(j,potnatveg);

vm_bv.l(j,"crop_per",potnatveg) =
  sum((crop_per30,w), fm_croparea("y1995",j,w,crop_per30)) * fm_bii_coeff("crop_per",potnatveg) 
  * fm_luh2_side_layers(j,potnatveg);
