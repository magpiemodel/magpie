*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* initialize secdforest area depending on switch.
if(s35_secdf_distribution = 0,
  i35_secdforest(j,"acx") = pcm_land(j,"secdforest");
elseif s35_secdf_distribution = 1,
* ac0 is excluded here. Therefore no initial shifting is needed.
  i35_secdforest(j,ac)$(not sameas(ac,"ac0")) = pcm_land(j,"secdforest")/(card(ac)-1);
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
