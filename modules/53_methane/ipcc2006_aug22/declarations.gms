*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q53_emissionbal_ch4_ent_ferm(i)                   Detailed ch4 constraint for enteric fermentation before technical mitigation (tCH4)
 q53_emissionbal_ch4_awms(i)                       Detailed ch4 constraint for animal waste management systems before technical mitigation (tCH4)
 q53_emissionbal_ch4_rice(i)                       Detailed ch4 constraint for rice before technical mitigation (tCH4)
 q53_emissions_resid_burn(i)                       Estimates ch4 emissions from the burning of agricultural residues (Mt X-N)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq53_emissionbal_ch4_ent_ferm(t,i,type) Detailed ch4 constraint for enteric fermentation before technical mitigation (tCH4)
 oq53_emissionbal_ch4_awms(t,i,type)     Detailed ch4 constraint for animal waste management systems before technical mitigation (tCH4)
 oq53_emissionbal_ch4_rice(t,i,type)     Detailed ch4 constraint for rice before technical mitigation (tCH4)
 oq53_emissions_resid_burn(t,i,type)     Estimates ch4 emissions from the burning of agricultural residues (Mt X-N)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
