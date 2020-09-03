*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
pm_croparea_start(j,kcr) = sum(w, f30_croparea("y1995",j,w,kcr));
pm_croparea_start(j,kcr)$(pm_croparea_start(j,kcr)<0) = 0;
pm_area(j,kcr,w)         = f30_croparea("y1995",j,kcr,w);
