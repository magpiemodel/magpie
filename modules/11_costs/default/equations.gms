*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 q11_cost_glo .. vm_cost_glo =e=
                          sum(i2, v11_cost_reg(i2));

 q11_cost_reg(i2) .. v11_cost_reg(i2)
                   =e=
                   sum(kall, vm_cost_prod(i2,kall))
                   + sum((cell(i2,j2),land), vm_cost_landcon(j2,land))
                   + sum((cell(i2,j2),k), vm_cost_transp(j2,k))
                   + vm_tech_cost(i2)
                   + vm_nr_inorg_fert_costs(i2)
                   + vm_p_fert_costs(i2)
                   + vm_emission_costs(i2)
                   - vm_reward_cdr_aff(i2)
                   + vm_maccs_costs(i2)
                   + vm_cost_AEI(i2)
                   + vm_cost_trade(i2)
                   + vm_cost_fore(i2)
                   + vm_cost_cdr(i2)
                   + vm_cost_bioen(i2)
                   + vm_processing_costs(i2)
                   + vm_cost_processing(i2)
                   ;