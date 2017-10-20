*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

positive variables

 vm_nr_inorg_fert_reg(i,land_ag)  inorganic fertilizer application (Tg Nutrients)
 vm_nr_inorg_fert_costs(i)        cost of inorganic fertiliuers (Million USD)

;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_inorg_fert_reg(t,i,land_ag,type) inorganic fertilizer application (Tg Nutrients)
 ov_nr_inorg_fert_costs(t,i,type)       cost of inorganic fertiliuers (Million USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
