*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq51_emissions_inorg_fert(t,i,n_pollutants_direct,"marginal") = q51_emissions_inorg_fert.m(i,n_pollutants_direct);
 oq51_emissions_man_crop(t,i,n_pollutants_direct,"marginal")   = q51_emissions_man_crop.m(i,n_pollutants_direct);
 oq51_emissions_resid(t,i,n_pollutants_direct,"marginal")      = q51_emissions_resid.m(i,n_pollutants_direct);
 oq51_emissions_som(t,i,n_pollutants_direct,"marginal")        = q51_emissions_som.m(i,n_pollutants_direct);
 oq51_emissionbal_man_past(t,i,n_pollutants_direct,"marginal") = q51_emissionbal_man_past.m(i,n_pollutants_direct);
 oq51_emissionbal_awms(t,i,n_pollutants_direct,"marginal")     = q51_emissionbal_awms.m(i,n_pollutants_direct);
 oq51_emissions_indirect_n2o(t,i,emis_source_n51,"marginal")   = q51_emissions_indirect_n2o.m(i,emis_source_n51);
 oq51_emissions_inorg_fert(t,i,n_pollutants_direct,"level")    = q51_emissions_inorg_fert.l(i,n_pollutants_direct);
 oq51_emissions_man_crop(t,i,n_pollutants_direct,"level")      = q51_emissions_man_crop.l(i,n_pollutants_direct);
 oq51_emissions_resid(t,i,n_pollutants_direct,"level")         = q51_emissions_resid.l(i,n_pollutants_direct);
 oq51_emissions_som(t,i,n_pollutants_direct,"level")           = q51_emissions_som.l(i,n_pollutants_direct);
 oq51_emissionbal_man_past(t,i,n_pollutants_direct,"level")    = q51_emissionbal_man_past.l(i,n_pollutants_direct);
 oq51_emissionbal_awms(t,i,n_pollutants_direct,"level")        = q51_emissionbal_awms.l(i,n_pollutants_direct);
 oq51_emissions_indirect_n2o(t,i,emis_source_n51,"level")      = q51_emissions_indirect_n2o.l(i,emis_source_n51);
 oq51_emissions_inorg_fert(t,i,n_pollutants_direct,"upper")    = q51_emissions_inorg_fert.up(i,n_pollutants_direct);
 oq51_emissions_man_crop(t,i,n_pollutants_direct,"upper")      = q51_emissions_man_crop.up(i,n_pollutants_direct);
 oq51_emissions_resid(t,i,n_pollutants_direct,"upper")         = q51_emissions_resid.up(i,n_pollutants_direct);
 oq51_emissions_som(t,i,n_pollutants_direct,"upper")           = q51_emissions_som.up(i,n_pollutants_direct);
 oq51_emissionbal_man_past(t,i,n_pollutants_direct,"upper")    = q51_emissionbal_man_past.up(i,n_pollutants_direct);
 oq51_emissionbal_awms(t,i,n_pollutants_direct,"upper")        = q51_emissionbal_awms.up(i,n_pollutants_direct);
 oq51_emissions_indirect_n2o(t,i,emis_source_n51,"upper")      = q51_emissions_indirect_n2o.up(i,emis_source_n51);
 oq51_emissions_inorg_fert(t,i,n_pollutants_direct,"lower")    = q51_emissions_inorg_fert.lo(i,n_pollutants_direct);
 oq51_emissions_man_crop(t,i,n_pollutants_direct,"lower")      = q51_emissions_man_crop.lo(i,n_pollutants_direct);
 oq51_emissions_resid(t,i,n_pollutants_direct,"lower")         = q51_emissions_resid.lo(i,n_pollutants_direct);
 oq51_emissions_som(t,i,n_pollutants_direct,"lower")           = q51_emissions_som.lo(i,n_pollutants_direct);
 oq51_emissionbal_man_past(t,i,n_pollutants_direct,"lower")    = q51_emissionbal_man_past.lo(i,n_pollutants_direct);
 oq51_emissionbal_awms(t,i,n_pollutants_direct,"lower")        = q51_emissionbal_awms.lo(i,n_pollutants_direct);
 oq51_emissions_indirect_n2o(t,i,emis_source_n51,"lower")      = q51_emissions_indirect_n2o.lo(i,emis_source_n51);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
