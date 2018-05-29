*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*define mapping between ac and land35
ac_land35(ac,land35) = no;
ac_land35(ac,"new")  = yes$(ord(ac) = 1);
ac_land35(ac,"grow") = yes$(ord(ac) > 1 AND ord(ac) < card(ac));
ac_land35(ac,"old")  = yes$(ord(ac) = card(ac));

i35_ageclass_area(j,ac) = sum(ac_to_ac_poulter(ac,ac_poulter), f35_ageclass_area(j,ac_poulter));

i35_secdforest_ageclass_shr(j,ac) = 1/card(ac);
i35_secdforest_ageclass_area(j,ac) = i35_ageclass_area(j,ac)$(not sameas(ac,"acx"));
i35_secdforest_ageclass_shr(j,ac)$(sum(ac2, i35_secdforest_ageclass_area(j,ac2)) > 0) = 
		i35_secdforest_ageclass_area(j,ac)/sum(ac2, i35_secdforest_ageclass_area(j,ac2));
i35_secdforest(j,ac) = i35_secdforest_ageclass_shr(j,ac) * pcm_land(j,"secdforest");

i35_other_ageclass_shr(j,ac) = 1/card(ac);
i35_other_ageclass_shr(j,ac)$(sum(ac2, i35_ageclass_area(j,ac2)) > 0) = 
		i35_ageclass_area(j,ac)/sum(ac2, i35_ageclass_area(j,ac2));
i35_other(j,ac) = i35_other_ageclass_shr(j,ac) * pcm_land(j,"other");

p35_protect_shr(t,j,prot_type) = 0;

p35_recovered_forest(t,j,ac) = 0;

p35_min_forest(t,j) = f35_min_forest(t,j,"%c35_ad_policy%");
p35_min_cstock(t,j) = f35_min_cstock(t,j,"%c35_emis_policy%");
