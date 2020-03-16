*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' Therefore, the equation below is used to estimate the mitigation costs.
*' It is simply calculated as a product of GHG emissions before technical mitigation (`vm_btm_reg`), 
*' and the costs per unit of technical mitigation (`p57_maccs_costs_integral`).
*' The mitigation costs will go into the objective function of the model.

q57_total_costs(i2) ..
  vm_maccs_costs(i2) =g=
  sum((ct,emis_source), p57_maccs_costs_integral(ct,i2,emis_source,"n2o_n_direct")
		* vm_btm_reg(i2,emis_source,"n2o_n_direct")
        + p57_maccs_costs_integral(ct,i2,emis_source,"ch4")
		* vm_btm_reg(i2,emis_source,"ch4")
		);
