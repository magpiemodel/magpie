*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @equations

*' Manure is estimated based on feed intake minus the NPK incorporated
*' in the biomass of the slaughtered animal.
*' We distinguish 4 general animal waste management systems based on
*' what animals eat and where their manure remains. For simplification,
*' we assume that pastures receive the manure of grazed biomass,
*' while croplands receive the manure of cropbased feed. In reality,
*' manure from grazing may be also excreted in stables and vice versa.
*' Problematic may be in particular that grass can also be harvested and
*' fed to animals in stables, and manure from confinements may be applied
*' also to pastures. As both practices mostly appear in high-income countries
*' and may also be causally linked (as nutrient deficits of pastures have to
*' be balanced if biomass is removed), we assume they cancel out.
*' We therefore distinguish only 4 categories:
*' a) confined animals which receive concentrate feed and crop residues

 q55_bal_intake_confinement(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "confinement",npk) =e=
         sum(kcr,vm_dem_feed(i2,kli,kcr) * fm_attributes(npk,kcr))
         + sum(kap,vm_dem_feed(i2,kli,kap) * fm_attributes(npk,kap))
         + sum(ksd,vm_dem_feed(i2,kli,ksd) * fm_attributes(npk,ksd))
         + sum(kres,vm_dem_feed(i2,kli,kres) * fm_attributes(npk,kres)
		 *(1-(1-sum(ct,im_development_state(ct,i2))))*0.25)
         ;

*' b) grazing animals on pastures where the manure stays on pastures

 q55_bal_intake_grazing_pasture(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "grazing",npk) =e=
         (vm_dem_feed(i2,kli,"pasture")) * fm_attributes(npk,"pasture")
         *(1-ic55_manure_fuel_shr(i2,kli))
         ;
*' c) grazing animals on pastures where the manure is collected as household fuel

 q55_bal_intake_fuel(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "fuel",npk) =e=
         (vm_dem_feed(i2,kli,"pasture")) * fm_attributes(npk,"pasture")
         *sum(ct,ic55_manure_fuel_shr(i2,kli))
         ;

*' d) grazing animals eating crop residues on stubble fields.

 q55_bal_intake_grazing_cropland(i2,kli,npk) ..
         v55_feed_intake(i2, kli, "stubble_grazing",npk) =e=
         sum(kres,vm_dem_feed(i2,kli,kres) * fm_attributes(npk,kres)
         *(1 - sum(ct,im_development_state(ct,i2)))*0.25)
         ;

*' Please note that the share of residues fed via stubble grazing depends 
*' on the development state and has to be subtracted from the residues fed to confined animals. 
*' We assume that in developing regions 25% of residues are grazed by animals on stubble fields, 
*' whereas stubble grazing is assumed to not occur in developed regions.
		 
*' The manure is estimated by subtracting from feed a certain share which is
*' incorporated into animal biomass. This share depends on the productivity of
*' the animal and is calculated in the preprocessing, also for computational
*' reasons.

 q55_bal_manure(i2,kli,awms,npk) ..
         vm_manure(i2, kli, awms,npk) =e=
         v55_feed_intake(i2, kli, awms,npk)
         *(1-sum(ct,im_slaughter_feed_share(ct,i2,kli,npk)));

*' Manure excreted in confinements is further distinguished into 9 animal waste
*' management systems.
  q55_manure_confinement(i2,kli,awms_conf,npk) ..
         vm_manure_confinement(i2,kli,awms_conf, npk) =e=
         vm_manure(i2, kli, "confinement", npk) * ic55_awms_shr(i2,kli,awms_conf)
         ;

*' Each of these awms have different recycling shares
*' (and different emission factors,
*' see [51_nitrogen])
 q55_manure_recycling(i2,npk) ..
         vm_manure_recycling(i2,npk) =e=
         sum((awms_conf,kli),
             vm_manure_confinement(i2,kli,awms_conf, npk)
             * i55_manure_recycling_share(i2,kli,awms_conf,npk));