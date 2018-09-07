*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

equations
 q51_emissions_inorg_fert(i,n_pollutants_direct) detailed n2o constraint for inorganic fertilizer before technical mitigation (Mt Nr-X)
 q51_emissions_man_crop(i,n_pollutants_direct)  detailed n2o constraint for manure on cropland before technical mitigation   (Mt Nr-X)
 q51_emissions_resid(i,n_pollutants_direct)      detailed n2o constraint for residues before technical mitigation            (Mt Nr-X)
 q51_emissions_som(i,n_pollutants_direct)        detailed n2o constraint for soil organic matter loss before technical mitigation (Mt Nr-X)
 q51_emissionbal_man_past(i,n_pollutants_direct)   detailed n2o constraint for manure on pasture land before technical mitigation (Mt Nr-X)
 q51_emissionbal_awms(i,n_pollutants_direct)       detailed n2o constraint for animal waste management systems before technical mitigation  (Mt Nr-X)
 q51_emissions_indirect_n2o(i,emis_source_n51) estimates indirect emissions from volatilisation and leaching  (Mt Nr-X)  
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq51_emissions_inorg_fert(t,i,n_pollutants_direct,type) detailed n2o constraint for inorganic fertilizer before technical mitigation (Mt Nr-X)
 oq51_emissions_man_crop(t,i,n_pollutants_direct,type)   detailed n2o constraint for manure on cropland before technical mitigation   (Mt Nr-X)
 oq51_emissions_resid(t,i,n_pollutants_direct,type)      detailed n2o constraint for residues before technical mitigation            (Mt Nr-X)
 oq51_emissions_som(t,i,n_pollutants_direct,type)        detailed n2o constraint for soil organic matter loss before technical mitigation (Mt Nr-X)
 oq51_emissionbal_man_past(t,i,n_pollutants_direct,type) detailed n2o constraint for manure on pasture land before technical mitigation (Mt Nr-X)
 oq51_emissionbal_awms(t,i,n_pollutants_direct,type)     detailed n2o constraint for animal waste management systems before technical mitigation  (Mt Nr-X)
 oq51_emissions_indirect_n2o(t,i,emis_source_n51,type)   estimates indirect emissions from volatilisation and leaching  (Mt Nr-X)  
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
