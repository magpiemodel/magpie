*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c18_burn_scen  phaseout
*   options:    phaseout,constant

table f18_multicropping(t_all,i) Multicropping indicator as ratio of area harvested by physical area (1)
$ondelim
$include "./modules/18_residues/input/f18_multicropping.csv"
$offdelim;

table f18_attributes_residue_ag(attributes,kve) Nutrient content of aboveground crop residues in respective attribute units DM GJ Nr P K WM C (X per DM)
$ondelim
$include "./modules/18_residues/input/f18_attributes_residue_ag.csv"
$offdelim;


table f18_attributes_residue_bg(dm_nr,kve) Nutrient content of belowground crop residues in reactive nitorgen and carbon units Nr C (X per DM)
$ondelim
$include "./modules/18_residues/input/f18_attributes_residue_bg.csv"
$offdelim;

table f18_cgf(cgf,kve) Crop growth functions for all vegetation types containing slope intercept and belowground to aboveground ratio (1)
$ondelim
$include "./modules/18_residues/flexreg_apr16/input/f18_cgf.csv"
$offdelim;

table f18_res_use_burn(t_all,burn_scen18,dev18,kcr) Minimum and maximum burn share use for residues developing over time (1)
$ondelim
$include "./modules/18_residues/flexreg_apr16/input/f18_res_use_burn.cs3"
$offdelim;

parameter f18_res_combust_eff(kve)  Combustion efficiency of residue burning (1)
/
$ondelim
$include "./modules/18_residues/input/f18_res_combust_eff.cs4"
$offdelim
/;

parameter f18_fac_req_kres(kres) Factor requirements (USD05MER per tDM)
/
$ondelim
$include "./modules/18_residues/flexreg_apr16/input/f18_fac_req_kres.csv"
$offdelim
/;

*** EOF input.gms ***
