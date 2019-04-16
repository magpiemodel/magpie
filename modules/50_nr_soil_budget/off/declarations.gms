*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

positive variables

 vm_nr_inorg_fert_reg(i,land_ag)  inorganic fertilizer application (Tg N per yr)
 vm_nr_inorg_fert_costs(i)        cost of inorganic fertiliuers (mio. USD05MER per yr)

;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_nr_inorg_fert_reg(t,i,land_ag,type) inorganic fertilizer application (Tg N per yr)
 ov_nr_inorg_fert_costs(t,i,type)       cost of inorganic fertiliuers (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
