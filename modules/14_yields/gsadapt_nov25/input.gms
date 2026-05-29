*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_be_calib  regional
*   options:  regional  (biophysical calibration using Li2020 regional means)
*             global    (biophysical calibration using Li2020 global mean)
*             off       (no Li2020 biophysical calibration)

$setglobal c14_yields_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

scalars
  s14_limit_calib              Relative managament calibration switch (1=limited 0=pure relative) / 1 /
  s14_calib_ir2rf              Switch to calibrate rainfed to irrigated yield ratios (1=calib 0=not calib) / 1 /
  s14_degradation              Switch to include yield impacts of land degradation(0=no degradation 1=with degradation) / 0 /
  s14_yld_reduction_soil_loss  Decline of land productivity in areas with severe soil loss (1)     / 0.08 /
  s14_use_yield_calib          Switch for using or not using yield calibration factors from the preprocessing (1=use facs 0=not use facs) / 0 /
  s14_yld_past_switch          Spillover parameter for translating technological change in the crop sector into pasture yield increases  (1)     / 0.25 /
  s14_minimum_growing_stock    Minimum growing stock for timber harvest in natural vegetation (tDM per ha) / 5 /
  sm_carbon_fraction           Carbon fraction of dry matter (tC per tDM) / 0.5 /
  s14_use_gsadapt              Switch to use including growing period adaption (1) or not (0) for yield pattern (binary) / 0 /
  s14_gsadapt2tau              Switch to account for growing period adaption in tau (1) or not (0) (binary) / 0 /
;


******* Calibration factor
$onEmpty
table f14_yld_calib(i,ltype14) Calibration factor for the LPJmL yields (1)
$ondelim
$if exist "./modules/14_yields/input/f14_yld_calib.csv" $include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim
;
$offEmpty

* LPJmL2MAGPIE In nocc runs, should one replace the i14_yields variable with the constgsadapt variant?
* Now that constgsadapt is the "default" this will actually be a different fix, I guess on the tau side?
* Also, some renaming will need to occur here. The gsadapt constgsadapt file names and variables are inconsistent.

table f14_yields_constgsadapt(t_all,j,kve,w) LPJmL potential yields per cell WITHOUT gsadapt (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/lpj_yields_constgsadapt.cs3"
$offdelim
;

* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c14_yields_scenario%" == "nocc" f14_yields_constgsadapt(t_all,j,kve,w) = f14_yields_constgsadapt("y1995",j,kve,w);
$if "%c14_yields_scenario%" == "nocc_hist" f14_yields_constgsadapt(t_all,j,kve,w)$(m_year(t_all) > sm_fix_cc) = f14_yields_constgsadapt(t_all,j,kve,w)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f14_yields_constgsadapt,"j,kve,w");

table f14_yields(t_all,j,kve,w) LPJmL potential yields WITH gsadapt per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;

* set values to 1995 if nocc scenario is used, or to sm_fix_cc after sm_fix_cc if nocc_hist is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
$if "%c14_yields_scenario%" == "nocc_hist" f14_yields(t_all,j,kve,w)$(m_year(t_all) > sm_fix_cc) = f14_yields(t_all,j,kve,w)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f14_yields,"j,kve,w");

table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;


table f14_fao_yields_hist(t_all,i,kcr) FAO yields per region (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/gsadapt_nov25/input/f14_region_yields.cs3"
$offdelim
;
m_fillmissingyears(f14_fao_yields_hist,"i,kcr");

parameter f14_ir2rf_ratio(i) AQUASTAT ratio of irrigated to rainfed yields per region (1)
/
$ondelim
$include "./modules/14_yields/gsadapt_nov25/input/f14_ir2rf_ratio.cs4"
$offdelim
/
;

parameter fm_ipcc_bef(clcl) IPCC biomass expansion factor BEF (1)
/
$ondelim
$include "./modules/14_yields/input/f14_ipcc_bef.cs3"
$offdelim
/
;

parameter fm_aboveground_fraction(land_timber) Aboveground fraction of total biomass (1)
/
$ondelim
$include "./modules/14_yields/input/f14_aboveground_fraction.csv"
$offdelim
/
;

$onEmpty
table f14_yld_ncp_report(t_all,j,ncp_type14) Share of land with intact natures contributions to people (NCP) (1)
$ondelim
$if exist "./modules/14_yields/input/f14_yld_ncp_report.cs3" $include "./modules/14_yields/input/f14_yld_ncp_report.cs3"
$offdelim
;
$offEmpty

parameter f14_kcr_pollinator_dependence(kcr) Share of total yield dependent on biotic pollination (1)
/
$ondelim
$include "./modules/14_yields/input/f14_kcr_pollinator_dependence.csv"
$offdelim
/
;

table f14_region_be_yields(i,kbe14) Li2020 reference yields for bioenergy crops per region (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/gsadapt_nov25/input/f14_region_be_yields.cs3"
$offdelim
;

parameter f14_global_be_yields(kbe14) Li2020 reference yields for bioenergy crops at global level (tDM per ha per yr)
/
$ondelim
$include "./modules/14_yields/gsadapt_nov25/input/f14_global_be_yields.csv"
$offdelim
/
;

table f14_cluster_be_croparea_weights(j,kbe14,w) Cropland area weights per cluster for Li2020 bioenergy yield aggregation (mio. ha)
$ondelim
$include "./modules/14_yields/gsadapt_nov25/input/f14_cluster_be_croparea_weights.cs3"
$offdelim
;
