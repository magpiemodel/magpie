*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Nitrogeneous emissions stem from manure applied to croplands, inorganic fertilizers, 
*' crop residues decaying on fields, soil organic matter loss, animal waste management, and 
*' manure excreted on pasture land. Additionally,  part of the NH3 and NOx emissions
*' as well as leached NO3 later result in indirect emissions of N2O when they are redeposited,
*' nitrified and dinitrified.
*'
*' Manure applied to croplands:
 q51_emissions_man_crop(i2,n_pollutants_direct)..
                 vm_btm_reg(i2,"man_crop",n_pollutants_direct)
                 =e=
                 vm_manure_recycling(i2,"nr")
                 * f51_ef_n_soil(n_pollutants_direct,"man_crop");

*' inorganic fertilizers:
 q51_emissions_inorg_fert(i2,n_pollutants_direct)..
                 vm_btm_reg(i2,"inorg_fert",n_pollutants_direct)
                 =e=
                 sum(land_ag,vm_nr_inorg_fert_reg(i2,land_ag))
                 * f51_ef_n_soil(n_pollutants_direct,"inorg_fert");

*' crop residues decaying on fields:
 q51_emissions_resid(i2,n_pollutants_direct)..
                 vm_btm_reg(i2,"resid",n_pollutants_direct)
                 =e=
                 vm_res_recycling(i2,"nr") * f51_ef_n_soil(n_pollutants_direct,"resid");

*' soil organic matter loss:
 q51_emissions_som(i2,n_pollutants_direct)..
                 vm_btm_reg(i2,"som",n_pollutants_direct)
                 =e=
                 sum(cell(i2,j2),vm_nr_som(j2)) * f51_ef_n_soil(n_pollutants_direct,"som");

*' animal waste management:
 q51_emissionbal_awms(i2,n_pollutants_direct) ..
                 vm_btm_reg(i2,"awms",n_pollutants_direct)
                 =e=
                 sum((kli,awms_conf),
                    vm_manure_confinement(i2,kli,awms_conf,"nr")
                    * f51_ef3_confinement(i2,kli,awms_conf,n_pollutants_direct));

*' and manure excreted on pasture land:
 q51_emissionbal_man_past(i2,n_pollutants_direct) ..
                 vm_btm_reg(i2,"man_past",n_pollutants_direct)
                 =e=
                 sum((awms_prp,kli),
                     vm_manure(i2, kli, awms_prp, "nr")
                     * f51_ef3_prp(i2,n_pollutants_direct,kli));

*' Indirect emissions from NH3, NOx and NO3: 
 q51_emissions_indirect_n2o(i2,emis_source_n51) ..
                 vm_btm_reg(i2,emis_source_n51,"n2o_n_indirect")
                 =e=
                 sum(pollutant_nh3no2_51,vm_emissions_reg(i2,emis_source_n51,pollutant_nh3no2_51))
                    * f51_ipcc_ef("ef_4","best")
                 + vm_emissions_reg(i2,emis_source_n51,"no3_n")
                   * f51_ipcc_ef("ef_5","best");

*** EOF constraints.gms ***