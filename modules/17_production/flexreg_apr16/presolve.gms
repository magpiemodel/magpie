*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

if (ord(t) = 1,

$ifthen "%c17_prod_init%" == "ON"
vm_prod.l(j,kcr)=sum(cell(i,j),sum(w,fm_croparea("y1995",j,w,kcr)*pm_yields_hist("y1995",j,kcr,w))* sum(supreg(h,i),fm_tau1995(h)));
$endif

    );
