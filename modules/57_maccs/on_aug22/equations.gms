*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Therefore, the equation below is used to estimate the mitigation costs.
*' MACC costs are calculated based on emissions BEFORE technical mitigation.
*' These emissions are here calculated back from the final emissions, using
*' the mitigated shares. Please note that in some cases (e.g. N2O emissions
*' from soils) there is an intended mismatch between the actual mitigated
*' quantities, and the quantities for which abatement has to be paid. As can
*' be seen in the respective emission module (e.g. 50_nr_soil_budget), the
*' mitigation quantity is reduced if baseline efficiencies are already high,
*' but the mitigation costs still apply fully, as the mitigation "effort"
*' is the same.
*' Mitigation costs are then calculated as the product of GHG emissions
*' before technical mitigation, and the costs per unit of technical mitigation.
*' The mitigation costs will go into the objective function of the model.

*' To avoid double-accounting, the fertilizer savings that reduce the costs of
*' the MACCs have to be added again to the MACCs, as the fertilizer costs are
*' endogenous in our model and fall with rising MACCs. We ex-post replicate
*' these implicit cost savings by assuming that they calculate the MACCs emission
*' savings proportional to fertilizer savings. Fertilization quantity is derived by
*' calculating emissions back to fertilization using the default emission factor
*' by the IPCC that is likely the basis for their estimates (E=F*EF, F= E/EF).

*' Costs are assumed to be factor costs and split into a labor and a capital part.
*' The labor share is scaled according to the changes in wages and corresponding 
*' productivity change.

q57_labor_costs(i2) ..
  vm_maccs_costs(i2,"labor") =e=
  (sum((ct,emis_source,pollutants_maccs57), p57_maccs_costs_integral(ct,i2,emis_source,pollutants_maccs57)
      * vm_emissions_reg(i2,emis_source,pollutants_maccs57) / (1 - im_maccs_mitigation(ct,i2,emis_source,pollutants_maccs57)))
    + sum(emis_source_inorg_fert_n2o,
      (vm_emissions_reg(i2,emis_source_inorg_fert_n2o,"n2o_n_direct") / s57_implicit_emis_factor) *
      sum(ct,im_maccs_mitigation(ct,i2,emis_source_inorg_fert_n2o,"n2o_n_direct")) * s57_implicit_fert_cost))
  * sum(ct, pm_cost_share_crops(ct ,i2,"labor") * (1/pm_productivity_gain_from_wages(ct,i2)) * 
          (pm_hourly_costs(ct,i2,"scenario") / pm_hourly_costs(ct,i2,"baseline")));

q57_capital_costs(i2) ..
  vm_maccs_costs(i2,"capital") =e=
  (sum((ct,emis_source,pollutants_maccs57), p57_maccs_costs_integral(ct,i2,emis_source,pollutants_maccs57)
      * vm_emissions_reg(i2,emis_source,pollutants_maccs57) / (1 - im_maccs_mitigation(ct,i2,emis_source,pollutants_maccs57)))
    + sum(emis_source_inorg_fert_n2o,
      (vm_emissions_reg(i2,emis_source_inorg_fert_n2o,"n2o_n_direct") / s57_implicit_emis_factor) *
      sum(ct,im_maccs_mitigation(ct,i2,emis_source_inorg_fert_n2o,"n2o_n_direct")) * s57_implicit_fert_cost))
  * sum(ct, pm_cost_share_crops(ct ,i2,"capital"));
