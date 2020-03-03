*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q14_yield_crop(j2,kcr,w) ..
 vm_yld(j2,kcr,w) =e= sum(ct,i14_yields(ct,j2,kcr,w))*sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2));

*' For the current time step of the optimization, cellular yields of irrigated 
*' and rainfed crops are calculated by multiplying calibrated input yields from 
*' LPJmL with the intensification rate relative to the initial time step 1995.

q14_yield_past(j2,w) ..
 vm_yld(j2,"pasture",w) =e= sum(ct,i14_yields(ct,j2,"pasture",w))
                    *(1 + s14_yld_past_switch*(sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2)) - 1));

*' In the case of pasture yields, technological change cannot be fully
*' translated into yield increases. To account for that, the parameter
*' `s14_yld_past_switch` is defined to capture a certain magnitude of spillovers
*' that can range from 0 (no spillover) to 1 (full spillover).
