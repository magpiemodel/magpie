*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_labor_prod(t,j,"marginal") = vm_labor_prod.m(j);
 ov_labor_prod(t,j,"level")    = vm_labor_prod.l(j);
 ov_labor_prod(t,j,"upper")    = vm_labor_prod.up(j);
 ov_labor_prod(t,j,"lower")    = vm_labor_prod.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
