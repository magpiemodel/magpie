*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


table f18_multicropping(t_all,i) values above one indicate multicropping - below one fallow land (area harvested by physical area)
$ondelim
$include "./modules/18_residues/input/f18_multicropping.csv"
$offdelim;

table f18_attributes_residue_ag(attributes,kve)    Nutrient content of abovegroudn crop residues in t nutrient per t DM
$ondelim
$include "./modules/18_residues/input/f18_attributes_residue_ag.csv"
$offdelim;


table f18_attributes_residue_bg(dm_nr,kve)    Nutrient content of abovegroudn crop residues in t nutrient per t DM
$ondelim
$include "./modules/18_residues/input/f18_attributes_residue_bg.csv"
$offdelim;

table f18_cgf(cgf,kve) crop growth functions for all vegetation types containing slope intercept and bg_to_ag ratio (1)
$ondelim
$include "./modules/18_residues/flexreg_apr16/input/f18_cgf.csv"
$offdelim;

table f18_res_use_burn(dev18,kcr) minimum use of residues for a certain use (to be replaced by endogenous calcs) (1)
$ondelim
$include "./modules/18_residues/flexreg_apr16/input/f18_res_use_burn.csv"
$offdelim;

parameter f18_res_combust_eff(kve)  Combustion efficiency of residue burning (1)
/
$ondelim
$include "./modules/18_residues/input/f18_res_combust_eff.cs4"
$offdelim
/;

parameter f18_fac_req_kres(kres) Factor requirements (US$04 per ton DM)
/
$ondelim
$include "./modules/18_residues/flexreg_apr16/input/f18_fac_req_kres.csv"
$offdelim
/;

*** EOF input.gms ***
