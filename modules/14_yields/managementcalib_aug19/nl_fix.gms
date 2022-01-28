*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

vm_yld.fx(j,kcr,w) = sum(ct,i14_yields(ct,j,kcr,w))*sum((cell(i,j), supreg(h,i)),vm_tau.l(h)/fm_tau1995(h));

vm_yld.fx(j,"pasture",w) = sum(ct,i14_yields(ct,j,"pasture",w)*sum(cell(i,j),pm_past_mngmnt_factor(ct,i)));
