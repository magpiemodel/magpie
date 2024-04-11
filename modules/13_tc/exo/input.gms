*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


parameter fm_tau1995(h) Agricultural land use intensity tau in 1995 (1)
/
$ondelim
$include "./modules/13_tc/input/fm_tau1995.cs4"
$offdelim
/;

$setglobal c13_tccost  medium

table f13_tc_factor(t_all,scen13) Regression factor (USD05PPP per ha)
$ondelim
$include "./modules/13_tc/input/f13_tc_factor.cs3"
$offdelim
;

table f13_tc_exponent(t_all,scen13) Regression exponent (1)
$ondelim
$include "./modules/13_tc/input/f13_tc_exponent.cs3"
$offdelim
;


table f13_tau_scenario(t_all,h,tautype) tau scenario (1)
$ondelim
$include "./modules/13_tc/input/f13_tau_scenario.csv"
$offdelim
;

table fm_pastr_tau_hist(t_all,h) Historical managed pasture tau (1)
$ondelim
$include "./modules/13_tc/input/f13_pastr_tau_hist.csv"
$offdelim
;
