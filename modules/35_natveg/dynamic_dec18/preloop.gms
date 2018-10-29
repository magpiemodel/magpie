*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

i35_ageclass_area(j,ac) = sum(ac_poulter_to_ac(ac_poulter,ac), f35_ageclass_area(j,ac_poulter));

i35_ageclass_area_secdf(j,ac) = sum(ac_poulter_to_ac(ac_poulter,ac), f35_ageclass_area(j,ac_poulter)$(not sameas(ac_poulter,"class15")));

i35_ageclass_shr_grow(j,ac) = 1/card(ac);

i35_ageclass_shr_grow(j,ac)$(sum(ac2, i35_ageclass_area_secdf(j,ac2)) > 0) = i35_ageclass_area_secdf(j,ac)/sum(ac2, i35_ageclass_area_secdf(j,ac2));

i35_secdforest(j,ac) = pcm_land(j,"secdforest")*i35_ageclass_shr_grow(j,ac);

i35_other(j,ac) = 0;
i35_other(j,"acx") = pcm_land(j,"other");

p35_protect_shr(t,j,prot_type) = 0;

p35_recovered_forest(t,j,ac) = 0;

p35_min_forest(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","forest");
p35_min_other(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","other");

*initialize parameter
p35_other(t,j,ac) = 0;
p35_secdforest(t,j,ac) = 0;
