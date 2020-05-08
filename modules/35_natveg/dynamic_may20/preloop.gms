*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p35_ageclass_secdforest_area(j,ac_poulter) = f35_ageclass_area(j,ac_poulter);
** This probably causes issue with the way shares are calculated for acx.
** In Tropics, acx has much area which means much of the secondary forest is very old
** Setting it to 0 and then calculating the share is not correct because we ignore a big
** chunk of area and then assume that rest of the land is distributed in lower age-classes
*p35_ageclass_secdforest_area(j,"class15") = 0;

p35_ageclass_secdforest_shr(j,ac) = 0;
p35_ageclass_secdforest_shr(j,ac)$(sum(ac_poulter2, p35_ageclass_secdforest_area(j,ac_poulter2)) > 0)
                  =
                  sum(ac_poulter_to_ac(ac_poulter,ac),
                      p35_ageclass_secdforest_area(j,ac_poulter)
                      /
                      sum(ac_poulter2, p35_ageclass_secdforest_area(j,ac_poulter2)));
*This causes rounding errors in optimization.
*p35_ageclass_secdforest_shr(j,ac)$(sum(ac_poulter2, p35_ageclass_secdforest_area(j,ac_poulter2)) = 0) = 1/card(ac);

*i35_secdforest(j,ac) = round(pcm_land(j,"secdforest")*p35_ageclass_secdforest_shr(j,ac),5);

** Change rotation based on switch. If not use calculation before faustmann
if(s35_secdf_distribution = 0,
  i35_secdforest(j,"acx") = pcm_land(j,"secdforest");

  elseif s35_secdf_distribution = 1,
** acx here is 0 so secdf has a mask for never having highest acx class in 19956
  i35_secdforest(j,ac_sub) = pcm_land(j,"secdforest")/card(ac_sub);

  elseif s35_secdf_distribution = 2,
** acx here is 0 so secdf has a mask for never having highest acx class in 19956
  i35_secdforest(j,ac_sub) = round(pcm_land(j,"secdforest")*f35_ageclass_share(j,ac_sub),5);
);

*use residual approach to avoid rounding errors
*i35_secdforest(j,ac) = round(pcm_land(j,"secdforest")/card(ac),5);
i35_secdforest(j,"acx") = i35_secdforest(j,"acx") + (pcm_land(j,"secdforest") - sum(ac, i35_secdforest(j,ac)));
* Taking the redistributed area with lower age classes from overall secdf and putting them
* In highest age class is probably not correct
*i35_secdforest(j,"acx") = pcm_land(j,"secdforest") - sum(ac, i35_secdforest(j,ac));

i35_other(j,ac) = 0;
i35_other(j,"acx") = pcm_land(j,"other");
*i35_other(j,ac) = pcm_land(j,"other")/card(ac);

p35_protect_shr(t,j,prot_type) = 0;

p35_recovered_forest(t,j,ac) = 0;

p35_min_forest(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","forest");
p35_min_other(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","other");

*initialize parameter
p35_other(t,j,ac) = 0;
p35_secdforest(t,j,ac) = 0;
