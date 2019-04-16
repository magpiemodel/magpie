*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
