*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameter fm_tau1995(i) agricultural land use intensity tau in 1995 (1)
/
$ondelim
$include "./modules/13_tc/input/fm_tau1995.cs4"
$offdelim
/;

parameter f13_tcguess(i) guess for initial annual tc rates (1)
/
$ondelim
$include "./modules/13_tc/input/f13_tcguess.cs4"
$offdelim
/;

$setglobal c13_tccost  medium

table f13_tc_factor(t_all,scen13) regression factor (USD per ha)
$ondelim
$include "./modules/13_tc/input/f13_tc_factor.cs3"
$offdelim
;

table f13_tc_exponent(t_all,scen13) regression exponent (1)
$ondelim
$include "./modules/13_tc/input/f13_tc_exponent.cs3"
$offdelim
;
