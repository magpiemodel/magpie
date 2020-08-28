*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

***CROP YIELD CALCULATIONS**********************************************
q14_yield_crop(j2,kcr,w) ..
 vm_yld(j2,kcr,w) =e= sum(ct,i14_yields_calib(ct,j2,kcr,w) *
                        sum(cell(i2,j2), vm_tau(i2) / fm_tau1995(i2)));


***PASTURE YIELD CALCULATIONS*******************************************
*' Pasture yields are not linked to yield increases in the crop sector, but to
*' an exogenous pasture management factor `pm_past_mngmnt_factor`:

q14_yield_past(j2,w) ..
 vm_yld(j2,"pasture",w) =e=
 sum(ct,(i14_yields_calib(ct,j2,"pasture",w)
 *sum(cell(i2,j2),pm_past_mngmnt_factor(ct,i2))));
