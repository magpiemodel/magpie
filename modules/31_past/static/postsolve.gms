*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq31_cost_prod_past(t,i,"marginal") = q31_cost_prod_past.m(i);
 oq31_cost_prod_past(t,i,"level")    = q31_cost_prod_past.l(i);
 oq31_cost_prod_past(t,i,"upper")    = q31_cost_prod_past.up(i);
 oq31_cost_prod_past(t,i,"lower")    = q31_cost_prod_past.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

