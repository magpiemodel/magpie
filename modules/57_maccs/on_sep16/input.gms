*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* option: PBL_2007,PBL_2019
$setglobal c57_macc_version  PBL_2007

table f57_maccs_n2o(t_all,i,maccs_n2o,maccs_steps)  N2O MACC from Image model (percent)
$ondelim
$if "%c57_macc_version%" == "PBL_2007" $include "./modules/57_maccs/input/f57_maccs_n2o.cs3"
$if "%c57_macc_version%" == "PBL_2019" $include "./modules/57_maccs/input/f57_maccs_n2o_2019.cs3"
$offdelim
;

table f57_maccs_ch4(t_all,i,maccs_ch4,maccs_steps)  CH4 MACC from Image model (percent)
$ondelim
$if "%c57_macc_version%" == "PBL_2007" $include "./modules/57_maccs/input/f57_maccs_ch4.cs3"
$if "%c57_macc_version%" == "PBL_2019" $include "./modules/57_maccs/input/f57_maccs_ch4_2019.cs3"
$offdelim
;
