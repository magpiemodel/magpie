*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameter f53_ef_ch4_awms(t_all,i,kli) CH4 emission per livestock products (CH4 per tDM)
/
$ondelim
$include "./modules/53_methane/input/f53_EFch4AWMS.cs4"
$offdelim
/
;

parameter f53_ef_ch4_rice(t_all,i) CH4 emission per ha rice (CH4 per ha)
/
$ondelim
$include "./modules/53_methane/input/f53_EFch4Rice.cs4"
$offdelim
/
;

scalar
    s53_ef_ch4_res_ag_burn CH4 emissions from the burning of agricultural residues (tCH4 per tDM) / 0.0027 /
;

