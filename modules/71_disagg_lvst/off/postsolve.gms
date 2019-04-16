*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_costs_additional_mon(t,i,"marginal") = vm_costs_additional_mon.m(i);
 ov_costs_additional_mon(t,i,"level")    = vm_costs_additional_mon.l(i);
 ov_costs_additional_mon(t,i,"upper")    = vm_costs_additional_mon.up(i);
 ov_costs_additional_mon(t,i,"lower")    = vm_costs_additional_mon.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

