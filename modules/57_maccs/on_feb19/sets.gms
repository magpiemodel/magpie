*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets

  emis_source_inorg_fert_n2o(emis_source) subset inorg_fert_n2o emissions 
  /inorg_fert,resid,som,rice/

  emis_source_awms_manure_n2o(emis_source) subset awms_manure_n2o
  /man_crop,man_past,awms/

  emis_source_rice_ch4(emis_source) subset rice emissions
  /rice/
  
  emis_source_ent_ferm_ch4(emis_source) subset ent_ferm emissions
  /ent_ferm/
  
  emis_source_awms_ch4(emis_source) subset awms emissions
  /awms/

  maccs_ch4 ch4 mitigation categories with MACCS
   / rice_ch4, ent_ferm_ch4, awms_ch4 /
 
  maccs_n2o n2o mitigation categories with MACCS
   / inorg_fert_n2o, awms_manure_n2o /

  maccs_steps maccs tax level steps
   / 1*201 /

;
