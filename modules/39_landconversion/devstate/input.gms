*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
 s39_cost_establish_crop_max   Maximum cost for cropland expansion before calibration (USD05MER per hectare) / 15000 /
 s39_cost_establish_crop_min   Minimum cost for cropland expansion before calibration (USD05MER per hectare) / 6000 /
 s39_cost_establish_past   	   Cost for pasture land expansion (USD05MER per hectare)    / 8000 /
 s39_cost_establish_forestry   Cost for foresty land expansion (USD05MER per hectare)    / 1000 /
 s39_cost_establish_urban  	   Cost for urban land expansion (USD05MER per hectare)    / 10000 /
 s39_reward_crop_reduction     Reward for cropland reduction (USD05MER per hectare)    / 40000 /
 s39_cost_clearing    		   Clearing costs linked to removed biomass (USD05MER per ton C)  / 0 /
 s39_ignore_calib			   Switch for ignoring calibration factors (1) / 0 /
;

$onEmpty
parameter f39_calib(i,type39) Calibration factor for costs of cropland expansion (1)
/
$ondelim
$if exist "./modules/39_landconversion/input/f39_calib.cs4" $include "./modules/39_landconversion/input/f39_calib.cs4"
$offdelim
/;
$offEmpty
