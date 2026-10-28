*** |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ### nl_fix ###

vm_yld.fx(j,kcr,w) = sum(ct,i14_yields_calib(ct,j,kcr,w) / sum(cell(i,j), p14_yields_gsadapt_ratio_cumulative(ct,i))) * sum(cell(i,j),vm_tau.l(i, "crop") / fm_tau1995(i));
vm_yld.fx(j,"pasture",w) =  sum((ct, cell(i,j)), i14_yields_calib(ct,j,"pasture",w) * pm_past_mngmnt_factor(ct,i) * (1 + i14_yld_past_switch_eff("y1995",i) * (pcm_tau_core(i,"crop") / fm_tau1995(i) - 1)));
