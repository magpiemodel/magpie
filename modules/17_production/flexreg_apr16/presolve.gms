*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



pm_prod_init(j,kcr)=sum(w,fm_croparea("y1995",j,w,kcr)*pm_yields_semi_calib(j,kcr,w));

if (ord(t) = 1,

$ifthen "%c17_prod_init%" == "on"
vm_prod.l(j,kcr) = pm_prod_init(j,kcr);
$endif

    );
