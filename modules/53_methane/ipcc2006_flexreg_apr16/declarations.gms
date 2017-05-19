*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


equations
 q53_emissionbal_ch4_ent_ferm(i)                   detailed ch4 constraint for enteric fermentation before technical mitigation
 q53_emissionbal_ch4_awms(i)                       detailed ch4 constraint for animal waste management systems before technical mitigation
 q53_emissionbal_ch4_rice(i)                       detailed ch4 constraint for rice before technical mitigation
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq53_emissionbal_ch4_ent_ferm(t,i,type) detailed ch4 constraint for enteric fermentation before technical mitigation
 oq53_emissionbal_ch4_awms(t,i,type)     detailed ch4 constraint for animal waste management systems before technical mitigation
 oq53_emissionbal_ch4_rice(t,i,type)     detailed ch4 constraint for rice before technical mitigation
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
