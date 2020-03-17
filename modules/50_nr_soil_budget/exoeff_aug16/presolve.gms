*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


v50_nr_eff.fx(i) = f50_snupe(t,i,"%c50_scen_neff%");
v50_nr_eff_pasture.fx(i) = f50_nue_pasture(t,i,"%c50_scen_neff_pasture%");
i50_atmospheric_deposition_rates(t,j,land)=f50_atmospheric_deposition_rates(t,j,land,"%c50_dep_scen%");
