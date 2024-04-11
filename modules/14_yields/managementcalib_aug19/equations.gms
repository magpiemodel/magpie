*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

***CROP YIELD CALCULATIONS**********************************************

*' Technological change can increase the initial calibrated yields by:

q14_yield_crop(j2,kcr,w) ..
 vm_yld(j2,kcr,w) =e= sum(ct,i14_yields_calib(ct,j2,kcr,w)) *
                        sum((cell(i2,j2), supreg(h2,i2)), vm_tau(h2,"crop") / fm_tau1995(h2));

*' For the current time step of the optimization, cellular yields of irrigated
*' and rainfed crops are calculated by multiplying calibrated input yields from
*' LPJmL with the intensification rate relative to the initial time step 1995.

***PASTURE YIELD CALCULATIONS*******************************************

*' In the case of pasture yields, technological change cannot be fully
*' translated into yield increases, to address that, an exogenous pasture management
*' factor `pm_past_mngmnt_factor` is used to scale pasture yields based on the
*' number of cattle reared to fulfill the domestic demand for ruminant livestock
*' products in module 70.
*'
*' Additionally, the parameter `s14_yld_past_switch` can be used to capture a
*' certain magnitude of spillovers of the yield increase due to technological
*' change from the time step before. It can range from 0 (no spillover) to 1
*' (full spillover).

q14_yield_past(j2,w) ..
 vm_yld(j2,"pasture",w) =e=
 sum(ct,(i14_yields_calib(ct,j2,"pasture",w))
 * sum(cell(i2,j2),pm_past_mngmnt_factor(ct,i2)))
 * (1 + s14_yld_past_switch*(sum((cell(i2,j2), supreg(h2,i2)), pcm_tau(h2, "crop")/fm_tau1995(h2)) - 1));
