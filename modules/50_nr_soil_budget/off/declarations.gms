*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_nr_inorg_fert_reg(i,land_ag)  Inorganic fertilizer application (Tg N per yr)
 vm_nr_inorg_fert_costs(i)        Cost of inorganic fertiliuers (mio. USD05MER per yr)
 vm_nr_eff(i)                     Cropland nutrient uptake efficiency (Tg N per yr)
 vm_nr_eff_pasture(i)             Pasture nutrient uptake efficiency (Tg N per yr)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_inorg_fert_reg(t,i,land_ag,type) Inorganic fertilizer application (Tg N per yr)
 ov_nr_inorg_fert_costs(t,i,type)       Cost of inorganic fertiliuers (mio. USD05MER per yr)
 ov_nr_eff(t,i,type)                    Cropland nutrient uptake efficiency (Tg N per yr)
 ov_nr_eff_pasture(t,i,type)            Pasture nutrient uptake efficiency (Tg N per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
