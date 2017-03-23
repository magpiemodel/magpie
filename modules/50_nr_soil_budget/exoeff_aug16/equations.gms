*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


 q50_nr_cost_fert(i2) ..
                 vm_nr_inorg_fert_costs(i2)
                 =e=
                 vm_nr_inorg_fert_reg(i2) * 600
                 ;

 q50_managament_nitrogen(i2,kcr) .. vm_mi(i2)
                                         =n=
                                   (1-v50_nr_eff(i2));

 q50_nr_bal_crp(i2) ..
                 v50_nr_eff(i2) *
                 (
                   vm_res_recycling(i2,"nr")
                   + sum((cell(i2,j2),kcr,w), vm_area(j2,kcr,w) * f50_nr_fix_area(kcr))
                   + vm_manure_recycling(i2,"nr")
                   + sum(kli, vm_manure(i2, kli, "stubble_grazing","nr"))
                   + vm_nr_inorg_fert_reg(i2)
                   + sum(cell(i2,j2),vm_nr_som(j2))*0
                 )
                 =g=
                 sum(kcr,v50_nr_withdrawals(i2,kcr));

 q50_nr_withdrawals(i2,kcr) ..
                 v50_nr_withdrawals(i2,kcr)
                 =e=
                 (1-sum(ct,f50_nr_fix_ndfa(ct,i2,kcr))) *
                 (
                    vm_prod_reg(i2,kcr) * fm_attributes("nr",kcr)
                    + vm_res_biomass_ag(i2,kcr,"nr")
                    + vm_res_biomass_bg(i2,kcr,"nr")
                 )
                 - vm_dem_seed(i2,kcr)  * fm_attributes("nr",kcr)
                 ;
