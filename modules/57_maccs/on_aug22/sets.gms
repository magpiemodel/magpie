*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets

  emis_source_inorg_fert_n2o(emis_source) subset inorg_fert_n2o emissions
  /inorg_fert, resid, som, rice, man_crop, man_past/

  emis_source_awms_n2o(emis_source) subset awms_manure_n2o
  /awms/

  emis_source_rice_ch4(emis_source) subset rice emissions
  /rice/

  emis_source_ent_ferm_ch4(emis_source) subset ent_ferm emissions
  /ent_ferm/

  emis_source_awms_ch4(emis_source) subset awms emissions
  /awms/

  pollutants_maccs57(pollutants) pollutants via which MAC costs are calculated
  / ch4, n2o_n_direct /

  maccs_ch4 ch4 mitigation categories with MACCS
   / rice_ch4, ent_ferm_ch4, awms_ch4 /

  maccs_n2o n2o mitigation categories with MACCS
   / inorg_fert_n2o, awms_manure_n2o /

  maccs_steps maccs tax level steps
   / 1*201 /

  scen57 scenarios
   / Default, Optimistic, Pessimistic /

;
