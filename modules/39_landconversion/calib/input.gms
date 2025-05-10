*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s39_cost_establish_crop       Cost for cropland expansion before calibration (USD17MER per hectare) / 12300 /
 s39_reward_crop_reduction     Reward for cropland reduction before calibration (USD17MER per hectare) / 7380 /
 s39_cost_establish_past       Cost for pasture land expansion (USD17MER per hectare)    / 9840 /
 s39_cost_establish_forestry   Cost for forestry land expansion (USD17MER per hectare)    / 1230 /
 s39_cost_establish_urban      Cost for urban land expansion (USD17MER per hectare)    / 12300 /
 s39_ignore_calib        Switch for ignoring calibration factors (1) / 0 /
;

$onEmpty
table f39_calib(t_all,i,type39) Calibration factor for costs of cropland expansion (1)
$ondelim
$if exist "./modules/39_landconversion/input/f39_calib.csv" $include "./modules/39_landconversion/input/f39_calib.csv"
$offdelim
;
$offEmpty
