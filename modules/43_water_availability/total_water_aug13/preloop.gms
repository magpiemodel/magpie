*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

im_wat_avail(t,"surface",j) = f43_wat_avail(t,j);

im_wat_avail(t,"ground",j) = 0;
im_wat_avail(t,"ren_ground",j) = 0;
im_wat_avail(t,"technical",j) = 0;
