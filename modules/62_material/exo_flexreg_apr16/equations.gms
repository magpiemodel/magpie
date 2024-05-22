*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Estimation of material demand depends on the value set by switch
*' `s62_historical`. When it is set to 1, the material demand is estimated
*' purely based on the historical material demand as reported by FAO.
*' When `s62_historical` is switched to 0, the Material demand is calculated
*' as the scaled version of material demand in last historical timestep
*' depending on a scaling factor. This scaling factor is calculated as the
*' ratio beween the food demand from last timestep and the food demand from
*' the last historical time step. If an exogenous target for bioplastic production
*' is set, increasing material demand (substrate) for bioplastic production is included. 
*' For historic years it is assumed that this demand is already part of the
*' general material demand, therefore the double-counted demand is subtracted.

 q62_dem_material(i2,kall_excl_kforestry) ..
                      vm_dem_material(i2,kall_excl_kforestry)
                      =e=
                      sum(ct,f62_dem_material(ct,i2,kall_excl_kforestry))*s62_historical
                      +
                      (p62_dem_material_lastcalibyear(i2,kall_excl_kforestry) * p62_scaling_factor(i2))
                      *(1-s62_historical) + sum(ct, p62_bioplastic_substrate(ct, i2, kall_excl_kforestry)) -
                      sum(ct, p62_bioplastic_substrate_double_counted(ct,i2,kall_excl_kforestry))
                      ;

*' Demand for forestry products (wood and woodfuel) is provided by the timber module.

 q62_dem_material_forestry(i2,kforestry) ..
                      vm_dem_material(i2,kforestry)
                      =e=
                      sum(ct, pm_demand_forestry(ct,i2,kforestry));
                      ;
