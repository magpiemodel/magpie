*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

equations
 q51_emissions_inorg_fert(i,n_pollutants_direct)   estimates various emission types X from inorganic fertilizer before technical mitigation (Mt X-N)
 q51_emissions_man_crop(i,n_pollutants_direct)     estimates various emission types X from manure on cropland before technical mitigation   (Mt X-N)
 q51_emissions_resid(i,n_pollutants_direct)        estimates various emission types X from residues before technical mitigation            (Mt X-N)
 q51_emissions_resid_burn(i,n_pollutants_direct)   estimates various emission types X from residues burning (Mt X-N)
 q51_emissions_som(i,n_pollutants_direct)          estimates various emission types X from soil organic matter loss before technical mitigation (Mt X-N)
 q51_emissionbal_man_past(i,n_pollutants_direct)   estimates various emission types X from manure on pasture land before technical mitigation (Mt X-N)
 q51_emissionbal_awms(i,n_pollutants_direct)       estimates various emission types X from animal waste management systems before technical mitigation  (Mt X-N)
 q51_emissions_indirect_n2o(i,emis_source_n51)     estimates various emission types X from volatilisation and leaching  (Mt X-N)
;

parameters
  i51_ef_n_soil(t,i,n_pollutants_direct,emis_source_n_cropsoils51) emission factors for nitrogen emissions from cropland soils (tX-N per tN)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq51_emissions_inorg_fert(t,i,n_pollutants_direct,type) estimates various emission types X from inorganic fertilizer before technical mitigation (Mt X-N)
 oq51_emissions_man_crop(t,i,n_pollutants_direct,type)   estimates various emission types X from manure on cropland before technical mitigation   (Mt X-N)
 oq51_emissions_resid(t,i,n_pollutants_direct,type)      estimates various emission types X from residues before technical mitigation            (Mt X-N)
 oq51_emissions_resid_burn(t,i,n_pollutants_direct,type) estimates various emission types X from residues burning (Mt X-N)
 oq51_emissions_som(t,i,n_pollutants_direct,type)        estimates various emission types X from soil organic matter loss before technical mitigation (Mt X-N)
 oq51_emissionbal_man_past(t,i,n_pollutants_direct,type) estimates various emission types X from manure on pasture land before technical mitigation (Mt X-N)
 oq51_emissionbal_awms(t,i,n_pollutants_direct,type)     estimates various emission types X from animal waste management systems before technical mitigation  (Mt X-N)
 oq51_emissions_indirect_n2o(t,i,emis_source_n51,type)   estimates various emission types X from volatilisation and leaching  (Mt X-N)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
