*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' We first need to transform the MACC curves from a format where they are a function
*' of inputs (approach 1, IPCC) to a function of losses (approach 2, MAgPIE).
*' Approach 2 is more consistent, as emissions can only come from losses, and
*' in the case of nitrogen use efficiency (NUE=I/H), losses (L=I-H) are zero,
*' but approach 1 would still come up with positive emissions.
*' The two approaches (see module 51_nitrogen) are
*'
*' (1) E_1 = I_1 * EF * (1 - MACCs_O)
*'
*' (2) E_2 = I_2 * (1 - NUE_2) / (1 - NUE_ef) * EF
*'
*' with the further condition:
*'
*' (3) H = I_i * NUE_i
*'
*' (4) (1 - NUE_2) = (1 - NUE_b) * (1 - MACCs_T)
*'
*' E: emissions, I: nutrient inputs, EF: emission factor,
*' NUE: nitrogen use efficiency, H: harvested N
*' NUE_ef: the nitrogen use efficiency for which the EF is made
*' NUE_2: nitrogen use efficiency in our model
*' NUE_b: baseline nitrogen use efficiency before application of MACCs
*' MACCs_O: original MACCs to be applied on fertilizer application
*' MACCs_T: transformed MACCs to be applied on nitrogen surplus
*'
*' We want to derive Maccs_T under the condition that the measured reduction of
*' emissions (R = E / Eb) in both approaches remains equal.
*' combining 1 + 3 and 2 + 3

*' (4) R_1 = H / NUE_b * EF * (1 - MACCs_O) / (H / NUE_b * EF)
*' (5) R_2 = (H / NUE2 * (1 - NUE2) / (1 - NUE_ef) * EF) / (H / NUE_b * (1 - NUE_b) / (1 - NUE_ef) * EF)
*' (4+5) MACCs_T = MACCs_O * NUE_b / (1 + MACCs_O * (NUE_b - 1))

*' If the MACCs are expressed relative to a changing emission factor, this could
*' be accomodated in equation 4. Currently we assume a constant emission factor
*' implicit to the MACCs.
*' The year of NUE_ef should be fixed to the baseyear efficiency, as
*' alternative "baseline" improvements would otherwise not reduce the
*' mitigation potential of the MACCs.
*' If the MACCs relate to a global emission factor NUE_ef should be the global
*' NUE, otherwise the regional NUE.
*' The name of the MACC category "inorg_fert_n2o" actually includes all types
*' of soil N2O emissions. Most of these measures also reduce general Nr surpluses.
*' We therefor apply it here to Nr soil efficiency more generally.

if(s50_maccs_global_ef = 1,
  i50_maccs_mitigation_transf(t,i) =
    im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct")*s50_maccs_implicit_nue_glo / (1 + im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct") * (s50_maccs_implicit_nue_glo - 1));
  i50_maccs_mitigation_pasture_transf(t,i) =
    im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct")*s50_maccs_implicit_nue_glo / (1 + im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct") * (s50_maccs_implicit_nue_glo - 1));
else
  i50_maccs_mitigation_transf(t,i) =
    im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct")*i50_nr_eff_bau("y2010",i) / (1 + im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct") * (i50_nr_eff_bau("y2010",i) - 1));
  i50_maccs_mitigation_pasture_transf(t,i) =
    im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct")*i50_nr_eff_pasture_bau("y2010",i) / (1 + im_maccs_mitigation(t,i,"inorg_fert","n2o_n_direct") * (i50_nr_eff_pasture_bau("y2010",i) - 1));
);

*' After transformation of the MACCs, we can calculate NUE_2 (vm_nr_eff) as the
*' result of a baseline NUE improvement and an MACC-driven further increase of NUE.
*' The nitrogen use efficiency is the inverse of the nitrogen loss share.
*' The loss share is estimated as a baseline loss share that describes the
*' baseline technological improvement of NUE, and a reduction of this loss
*' share by technical mitigation.
*' We assume that the MACCs reduce the remaining losses proportional, so that
*' emissions cannot become negative, and the baseline improvement reduces the
*' mitigation potential of the MACCs.

 vm_nr_eff.fx(i) = 1 - (1-i50_nr_eff_bau(t,i)) * (1 - i50_maccs_mitigation_transf(t,i));
 vm_nr_eff_pasture.fx(i)= 1 - (1-i50_nr_eff_pasture_bau(t,i)) * (1 - i50_maccs_mitigation_pasture_transf(t,i));

*' @stop
