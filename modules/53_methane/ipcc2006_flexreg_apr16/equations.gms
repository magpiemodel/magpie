*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*'
*' We calculate methane emissions before technical mitigation(btm) in each regions (reg) (`vm_btm_reg`)
*' from the aforementioned three sources of emissions step-by-step in the following three equations.
*'
*' The first equation describes how CH4 emission from enteric fermentation is calculated.
*' The equation shows that total methane from enteric fermentation depends on
*' the animal feed demand type (`vm_dem_feed`) and
*' the purpose of raising livestock - either for meat (`livst_rum`) and/or milk (`livst_milk`).
*' The factor 1/55.65 t/GJ in the equation is the energy content of methane.
*' The other scalars - 0.065 and 0.03 - refer to the share of gross energy (ge) in feed
*' released as methane for dairy cattle and ruminants respectively.

 q53_emissionbal_ch4_ent_ferm(i2) ..
   vm_btm_reg(i2,"ent_ferm","ch4") =e= 1/55.65 *
  (sum(k_conc53, vm_dem_feed(i2,"livst_rum",k_conc53)
                *fm_attributes("ge",k_conc53)*0.03)
   + sum(k_conc53, vm_dem_feed(i2,"livst_milk",k_conc53)
                *fm_attributes("ge",k_conc53)*0.065)
   + sum((k_noconc53,k_ruminants53),vm_dem_feed(i2,k_ruminants53,k_noconc53)
                 *fm_attributes("ge",k_noconc53)*0.065));

*' As such, methane from enteric fermentation depends on the feed quality and the purpose of livestock farming.
*' The feed quality (measured by energy content of the feed type) can be `k_conc53`
*'  ( with high energy contents, for example, temperate and tropical cereals, maize,pulses) or `k_noconc53`
*' (for example, pasture, fodder,crop residues). The purpose of livestock raising `k_ruminants53`
*' can be either for meat (`livst_rum`) or for milk (`livst_milk`). The parameter `fm_attributes`
*' in MAgPIE captures a content of some thing (e.g. gross energy-ge, dry matter-dm, reactive nitrogen-nr)
*' in a given commodity.
*' These attributes or coefficients are then used in content conversions in may modules of the model.
*'
*' The second equation of this realization is meant to calculate CH4 emission from
*' animal waste management (AWM). In general, AWM depends on the amount of manure
*' excreted in confinements (such as stables or barns) (see [55_awms])and its
*' subsequent storage.
*' We calculate the CH4 emission per unit of nitrogen in manure based on @ipcc_2006_2006
*' and Manure Management Emissions from @FAOSTAT .
*' See the  module for more on calculation of methane from animal waste(or manure) .

 q53_emissionbal_ch4_awms(i2) ..
  vm_btm_reg(i2,"awms","ch4") =e=
            sum(kli, vm_manure(i2, kli, "confinement", "nr")
                * sum(ct,  f53_ef_ch4_awms(ct,i2,kli)));

*' The third equation of this realization calculates methane emissions from rice cultivation.
*' As presented below CH4 from rice is a function of harvested area of rice
*' and th CH4 emission intensity of rice (measured as CH4 per hectare of rice).
*' The calculation is based on @ipcc_2006_2006 and Rice Cultivation Emissions from @FAOSTAT.

 q53_emissionbal_ch4_rice(i2) ..
   vm_btm_reg(i2,"rice","ch4") =e=
          sum((cell(i2,j2),w), vm_area(j2,"rice_pro",w)
              * sum(ct,f53_ef_ch4_rice(ct,i2)));
