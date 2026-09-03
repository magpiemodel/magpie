*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ---- Base cost scalars ------------------------------------------------------
scalars
 s39_cost_establish_crop      Cost for cropland expansion before calibration (USD17MER per hectare) / 12300 /
 s39_reward_crop_reduction    Reward for cropland reduction before calibration (USD17MER per hectare) / 7380 /
 s39_cost_establish_past      Cost for pasture land expansion before calibration (USD17MER per hectare) / 9840 /
 s39_reward_past_reduction    Reward for pasture land reduction before calibration (USD17MER per hectare) / 5904 /
 s39_cost_establish_forestry  Cost for forestry land expansion (USD17MER per hectare) / 1230 /
 s39_cost_establish_urban     Cost for urban land expansion (USD17MER per hectare) / 12300 /
 s39_ignore_calib             Switch for ignoring regional calibration factors (1) / 0 /
* Set to 1 to ignore cluster-level calibration and fall back to regional for all clusters
 s39_ignore_calib_cluster     Switch for ignoring cluster-level calibration factors (1) / 0 /
;

* ---- Regional crop calibration (non-selected countries) --------------------
$onEmpty
table f39_calib(t_all,i,type39) Regional calibration factor for cropland expansion (1)
$ondelim
$if exist "./modules/39_landconversion/input/f39_calib.csv" $include "./modules/39_landconversion/input/f39_calib.csv"
$offdelim
;
$offEmpty

* ---- Regional pasture calibration (non-selected countries) -----------------
*' `f39_calib_past` is the pasture analogue of `f39_calib`. If absent, or for
*' regions with no data, preloop defaults to cost=1, reward=0, reproducing
*' the uncalibrated global base cost for pasture.
$onEmpty
table f39_calib_past(t_all,i,type39) Regional calibration factor for pasture expansion (1)
$ondelim
$if exist "./modules/39_landconversion/input/f39_calib_past.csv" $include "./modules/39_landconversion/input/f39_calib_past.csv"
$offdelim
;
$offEmpty

* ---- Cluster-level crop calibration (selected countries) -------------------
*' `f39_calib_cluster` must be pre-computed externally from observed
*' cluster-level cropland expansion and saved as a CSV with dimensions
*' (t_all, j, type39). If the file is absent, or for clusters with no data,
*' preloop falls back to the regional crop calibration value.
$onEmpty
table f39_calib_cluster(t_all,j,type39) Cluster-level calibration factor for cropland expansion (1)
$ondelim
$if exist "./modules/39_landconversion/calib_cluster/input/f39_calib_cluster.csv" $include "./modules/39_landconversion/calib_cluster/input/f39_calib_cluster.csv"
$offdelim
;
$offEmpty

* ---- Cluster-level pasture calibration (selected countries) ----------------
*' `f39_calib_past_cluster` is the pasture analogue of `f39_calib_cluster`.
*' It must be pre-computed externally from observed cluster-level pasture
*' expansion. If the file is absent, or for clusters with no data, preloop
*' falls back to the regional pasture calibration value.
$onEmpty
table f39_calib_past_cluster(t_all,j,type39) Cluster-level calibration factor for pasture expansion (1)
$ondelim
$if exist "./modules/39_landconversion/calib_cluster/input/f39_calib_past_cluster.csv" $include "./modules/39_landconversion/calib_cluster/input/f39_calib_past_cluster.csv"
$offdelim
;
$offEmpty
