*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


v50_nr_eff.fx(i) = f50_snupe(t,i,"%c50_scen_neff%");
v50_nr_eff_pasture.fx(i) = f50_nue_pasture(t,i,"%c50_scen_neff%");
ic50_atmospheric_deposition_rates(i,land)=f50_atmospheric_deposition_rates(t,i,land,"%c50_dep_scen%");
