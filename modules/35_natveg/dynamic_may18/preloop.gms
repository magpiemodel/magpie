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

i35_secdforest(j,ac) = 0;
i35_secdforest(j,"acx") = pcm_land(j,"secdforest");

i35_other(j,ac) = 0;
i35_other(j,"acx") = pcm_land(j,"other");

p35_protect_shr(t,j,prot_type) = 0;

p35_recovered_forest(t,j,ac) = 0;

p35_min_forest(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","forest");
p35_min_other(t,j) = f35_min_land_stock(t,j,"%c35_ad_policy%","other");

*initialize parameter 
p35_other(t,j,ac,when) = 0;
p35_secdforest(t,j,ac,when) = 0;
