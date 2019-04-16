*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


equations
 q53_emissionbal_ch4_ent_ferm(i)                   Detailed ch4 constraint for enteric fermentation before technical mitigation (tCH4)
 q53_emissionbal_ch4_awms(i)                       Detailed ch4 constraint for animal waste management systems before technical mitigation (tCH4)
 q53_emissionbal_ch4_rice(i)                       Detailed ch4 constraint for rice before technical mitigation (tCH4)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq53_emissionbal_ch4_ent_ferm(t,i,type) Detailed ch4 constraint for enteric fermentation before technical mitigation (tCH4)
 oq53_emissionbal_ch4_awms(t,i,type)     Detailed ch4 constraint for animal waste management systems before technical mitigation (tCH4)
 oq53_emissionbal_ch4_rice(t,i,type)     Detailed ch4 constraint for rice before technical mitigation (tCH4)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
