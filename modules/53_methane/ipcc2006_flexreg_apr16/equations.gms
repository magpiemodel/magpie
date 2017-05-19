*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


** enteric fermentation
* The factor 1/55.65 t/GJ is the energy content of methane
* 0.065 is the share of GE in feed released as methane for dairy cattle
 q53_emissionbal_ch4_ent_ferm(i2) ..
                 vm_btm_reg(i2,"ent_ferm","ch4")
                 =e=
                 (
                 sum(k_concentrate53, vm_dem_feed(i2,"livst_rum",k_concentrate53)*fm_attributes("ge",k_concentrate53)*0.03)
                 + sum(k_concentrate53, vm_dem_feed(i2,"livst_milk",k_concentrate53)*fm_attributes("ge",k_concentrate53)*0.065)
                 + sum((k_noconcentrate53,k_ruminants53),
                     vm_dem_feed(i2,k_ruminants53,k_noconcentrate53)*fm_attributes("ge",k_noconcentrate53)*0.065)
                 ) / 55.65;

** animal waste management
 q53_emissionbal_ch4_awms(i2) ..
                 vm_btm_reg(i2,"awms","ch4")
                 =e=
                 sum(kli, vm_manure(i2, kli, "confinement", "nr")
                 * sum(ct,  f53_ef_ch4_awms(ct,i2,kli)));

** rice
 q53_emissionbal_ch4_rice(i2) ..
                 vm_btm_reg(i2,"rice","ch4")
                 =e=
                 sum((cell(i2,j2),w), vm_area(j2,"rice_pro",w)
                  * sum(ct,f53_ef_ch4_rice(ct,i2)));
