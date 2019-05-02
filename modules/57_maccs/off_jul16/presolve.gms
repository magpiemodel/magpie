*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Accordingly, this implementation sets the cost of technical mitigation of GHG emissions (`vm_maccs_costs`)
*' to zero. Please see and compare this with the equation in the next realization.

vm_maccs_costs.fx(i) = 0;
im_maccs_mitigation(t,i,emis_source,pollutants) = 0;
