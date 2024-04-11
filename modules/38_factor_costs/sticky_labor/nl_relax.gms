*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* ### nl_relax ###

v38_laborhours_need.l(j,kcr) = v38_laborhours_need.l(j,kcr) * 1.1;
v38_capital_need.l(j,kcr,"immobile") = sum(cell(i,j), (i38_ces_shr(j,kcr) / (i38_ces_scale(j,kcr)**s38_ces_elast_par - (1-i38_ces_shr(j,kcr))*(pm_labor_prod(t,j) * pm_productivity_gain_from_wages(t,i)*v38_laborhours_need.l(j,kcr)**(-s38_ces_elast_par))))**(1/s38_ces_elast_par)) * s38_immobile;
v38_capital_need.l(j,kcr,"mobile") = v38_capital_need.l(j,kcr,"immobile") * (1-s38_immobile) / s38_immobile;
