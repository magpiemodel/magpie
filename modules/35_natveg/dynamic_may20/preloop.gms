*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

** Change rotation based on switch. If not use calculation before faustmann
if(s35_secdf_distribution = 0,
  i35_secdforest(j,"acx") = pcm_land(j,"secdforest");

  elseif s35_secdf_distribution = 1,
  i35_secdforest(j,ac_sub) = pcm_land(j,"secdforest")/card(ac_sub);
);

*use residual approach to avoid rounding errors
i35_secdforest(j,"acx") = i35_secdforest(j,"acx") + (pcm_land(j,"secdforest") - sum(ac, i35_secdforest(j,ac)));

i35_other(j,ac) = 0;
i35_other(j,"acx") = pcm_land(j,"other");

p35_protect_shr(t,j,prot_type) = 0;

p35_recovered_forest(t,j,ac) = 0;

p35_min_forest(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","forest");
p35_min_other(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","other");

*initialize parameter
p35_other(t,j,ac) = 0;
p35_secdforest(t,j,ac) = 0;
