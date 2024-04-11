*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Global cost for cropland expansion are scaled with a calibration factor (i39_calib).
* The calibration factor has been derived with the goal of matching regional cropland in 2015 with historic data.
* In addition, regions with a calibration factor > 1 and with a decline of cropland between 1995 and 2015 in historic data see a reward for cropland reduction.

i39_cost_establish(t,i,"crop") = s39_cost_establish_crop * i39_calib(t,i,"cost");
i39_reward_reduction(t,i,"crop") = s39_reward_crop_reduction * i39_calib(t,i,"reward");
i39_cost_establish(t,i,"past") = s39_cost_establish_past;
i39_cost_establish(t,i,"forestry") = s39_cost_establish_forestry;
i39_cost_establish(t,i,"urban") = s39_cost_establish_urban;
