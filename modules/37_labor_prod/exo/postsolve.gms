*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_labor_prod(t,j,"marginal")   = vm_labor_prod.m(j);
 ov37_adapt_irr(t,j,"marginal")  = v37_adapt_irr.m(j);
 ov37_adapt_fore(t,j,"marginal") = v37_adapt_fore.m(j);
 ov37_adapt_harv(t,j,"marginal") = v37_adapt_harv.m(j);
 oq37_labor_prod(t,j,"marginal") = q37_labor_prod.m(j);
 oq37_adapt_irr(t,j,"marginal")  = q37_adapt_irr.m(j);
 oq37_adapt_fore(t,j,"marginal") = q37_adapt_fore.m(j);
 oq37_adapt_harv(t,j,"marginal") = q37_adapt_harv.m(j);
 ov_labor_prod(t,j,"level")      = vm_labor_prod.l(j);
 ov37_adapt_irr(t,j,"level")     = v37_adapt_irr.l(j);
 ov37_adapt_fore(t,j,"level")    = v37_adapt_fore.l(j);
 ov37_adapt_harv(t,j,"level")    = v37_adapt_harv.l(j);
 oq37_labor_prod(t,j,"level")    = q37_labor_prod.l(j);
 oq37_adapt_irr(t,j,"level")     = q37_adapt_irr.l(j);
 oq37_adapt_fore(t,j,"level")    = q37_adapt_fore.l(j);
 oq37_adapt_harv(t,j,"level")    = q37_adapt_harv.l(j);
 ov_labor_prod(t,j,"upper")      = vm_labor_prod.up(j);
 ov37_adapt_irr(t,j,"upper")     = v37_adapt_irr.up(j);
 ov37_adapt_fore(t,j,"upper")    = v37_adapt_fore.up(j);
 ov37_adapt_harv(t,j,"upper")    = v37_adapt_harv.up(j);
 oq37_labor_prod(t,j,"upper")    = q37_labor_prod.up(j);
 oq37_adapt_irr(t,j,"upper")     = q37_adapt_irr.up(j);
 oq37_adapt_fore(t,j,"upper")    = q37_adapt_fore.up(j);
 oq37_adapt_harv(t,j,"upper")    = q37_adapt_harv.up(j);
 ov_labor_prod(t,j,"lower")      = vm_labor_prod.lo(j);
 ov37_adapt_irr(t,j,"lower")     = v37_adapt_irr.lo(j);
 ov37_adapt_fore(t,j,"lower")    = v37_adapt_fore.lo(j);
 ov37_adapt_harv(t,j,"lower")    = v37_adapt_harv.lo(j);
 oq37_labor_prod(t,j,"lower")    = q37_labor_prod.lo(j);
 oq37_adapt_irr(t,j,"lower")     = q37_adapt_irr.lo(j);
 oq37_adapt_fore(t,j,"lower")    = q37_adapt_fore.lo(j);
 oq37_adapt_harv(t,j,"lower")    = q37_adapt_harv.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
