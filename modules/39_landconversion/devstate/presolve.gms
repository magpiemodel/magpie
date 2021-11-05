*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*Global cost for cropland expansion are scaled with regional development state (0-1), with s39_cost_establish_crop_min as lower bound.
if(ord(t) = 1,
	i39_cost_establish(t,i,"crop") = max(s39_cost_establish_crop_min,s39_cost_establish_crop_max*im_development_state(t,i));
	i39_reward_reduction(t,i,"crop") = 0;
else
	i39_cost_establish(t,i,"crop") = max(s39_cost_establish_crop_min,s39_cost_establish_crop_max*im_development_state(t,i)) * i39_calib(i,"cost");
	i39_reward_reduction(t,i,"crop") = s39_reward_crop_reduction * i39_calib(i,"reward");
);
i39_cost_establish(t,i,"past") = s39_cost_establish_past;
i39_cost_establish(t,i,"forestry") = s39_cost_establish_forestry;
i39_cost_establish(t,i,"urban") = s39_cost_establish_urban;

