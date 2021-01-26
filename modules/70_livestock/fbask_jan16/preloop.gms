*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
loop(t_all,
 if(m_year(t_all) <= sm_fix_SSP2,
  im_slaughter_feed_share(t_all,i,kap,attributes) = f70_slaughter_feed_share(t_all,i,kap,attributes,"ssp2");
  i70_livestock_productivity(t_all,i,sys) = f70_livestock_productivity(t_all,i,sys,"ssp2");
  im_feed_baskets(t_all,i,kap,kall) = f70_feed_baskets(t_all,i,kap,kall,"ssp2");
 else
  im_slaughter_feed_share(t_all,i,kap,attributes) = f70_slaughter_feed_share(t_all,i,kap,attributes,"%c70_feed_scen%");
  i70_livestock_productivity(t_all,i,sys) = f70_livestock_productivity(t_all,i,sys,"%c70_feed_scen%");
  im_feed_baskets(t_all,i,kap,kall) = f70_feed_baskets(t_all,i,kap,kall,"%c70_feed_scen%");
 );
);


* Switch to determine countries for which feed substitution scenarios shall be applied.
* In the default case, the food scenario affects all countries when activated.
p70_country_dummy(iso) = 0;
p70_country_dummy(scen_countries70) = 1;


* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p70_feedscen_region_shr(t_all,i) = sum(i_to_iso(i,iso), p70_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

* Feed substitution scenarios including functional forms, targets and transition periods
* Note: p70_feedscen_region_shr(t,i) is 1 in the default case)
i70_cereal_fadeout(t_all,i) = 1 - p70_feedscen_region_shr(t_all,i)*(1-f70_feed_substitution_fader(t_all,"%c70_all_scen%"));
i70_foddr_fadeout(t_all,i) = 1 - p70_feedscen_region_shr(t_all,i)*(1-f70_feed_substitution_fader(t_all,"%c70_soybean_scen%"));

*** Substitution of cereal feed with single-cell protein (SCP)
*convert from DM to Nr
im_feed_baskets(t_all,i,kap,kcer70) = im_feed_baskets(t_all,i,kap,kcer70)*fm_attributes("nr",kcer70);
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")*fm_attributes("nr","scp");
*replace feed with SCP based on Nr
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")
             + sum(kcer70, im_feed_baskets(t_all,i,kap,kcer70) * (1-i70_cereal_fadeout(t_all,i)));
im_feed_baskets(t_all,i,kap,kcer70) =
               im_feed_baskets(t_all,i,kap,kcer70) * i70_cereal_fadeout(t_all,i);
*convert back from Nr to DM
im_feed_baskets(t_all,i,kap,kcer70) = im_feed_baskets(t_all,i,kap,kcer70)/fm_attributes("nr",kcer70);
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")/fm_attributes("nr","scp");

*** Substitution of foddr feed with single-cell protein (SCP)
*convert from DM to Nr
im_feed_baskets(t_all,i,kap,"foddr") = im_feed_baskets(t_all,i,kap,"foddr")*fm_attributes("nr","foddr");
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")*fm_attributes("nr","scp");
*replace feed with SCP based on Nr
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")
             + im_feed_baskets(t_all,i,kap,"foddr") * (1-i70_foddr_fadeout(t_all,i));
im_feed_baskets(t_all,i,kap,"foddr") =
               im_feed_baskets(t_all,i,kap,"foddr") * i70_foddr_fadeout(t_all,i);
*convert back from Nr to DM
im_feed_baskets(t_all,i,kap,"foddr") = im_feed_baskets(t_all,i,kap,"foddr")/fm_attributes("nr","foddr");
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")/fm_attributes("nr","scp");

