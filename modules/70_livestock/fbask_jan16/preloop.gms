*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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

* set default livestock productivity to avoid division of zero in presolve.gms
i70_livestock_productivity(t_all,i,sys)$(i70_livestock_productivity(t_all,i,sys)=0) = 0.02;

* Switch to determine countries for which feed substitution scenarios shall be applied.
* In the default case, the food scenario affects all countries when activated.
p70_country_dummy(iso) = 0;
p70_country_dummy(scen_countries70) = 1;


* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p70_feedscen_region_shr(t_all,i) = sum(i_to_iso(i,iso), p70_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));


if (s70_subst_functional_form = 1,

  m_linear_time_interpol(p70_cereal_subst_fader,s70_feed_substitution_start,s70_feed_substitution_target,0,s70_cereal_scp_substitution);
  m_linear_time_interpol(p70_foddr_subst_fader,s70_feed_substitution_start,s70_feed_substitution_target,0,s70_foddr_scp_substitution);

elseif s70_subst_functional_form = 2,

  m_sigmoid_time_interpol(p70_cereal_subst_fader,s70_feed_substitution_start,s70_feed_substitution_target,0,s70_cereal_scp_substitution);
  m_sigmoid_time_interpol(p70_foddr_subst_fader,s70_feed_substitution_start,s70_feed_substitution_target,0,s70_foddr_scp_substitution);

);

* Feed substitution scenarios including functional forms, targets and transition periods
* Note: p70_feedscen_region_shr(t,i) is 1 in the default case)
i70_cereal_scp_fadeout(t_all,i) = 1 - p70_feedscen_region_shr(t_all,i)*p70_cereal_subst_fader(t_all);
i70_foddr_scp_fadeout(t_all,i) = 1 - p70_feedscen_region_shr(t_all,i)*p70_foddr_subst_fader(t_all);


*** Substitution of cereal feed (kcer70) with single-cell protein (SCP) based on Nr
* Before the substitution, kcer70 is converted from DM to Nr
* using fm_attributes("nr",kcer70).
* After the substitution of kcer70 with SCP (1-i70_cereal_scp_fadeout), SCP is converted
* back DM fm_attributes("nr","scp").
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")
             + sum(kcer70, im_feed_baskets(t_all,i,kap,kcer70) * (1-i70_cereal_scp_fadeout(t_all,i)) *
             fm_attributes("nr",kcer70)) / fm_attributes("nr","scp");
im_feed_baskets(t_all,i,kap,kcer70) =
               im_feed_baskets(t_all,i,kap,kcer70) * i70_cereal_scp_fadeout(t_all,i);

*** Substitution of foddr feed with single-cell protein (SCP) based on Nr
* Before the substitution, foddr is converted from DM to Nr
* using fm_attributes("nr","foddr").
* After the substitution of foddr with SCP (1-i70_foddr_scp_fadeout), SCP is converted
* back DM fm_attributes("nr","scp").
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")
             + (im_feed_baskets(t_all,i,kap,"foddr") * (1-i70_foddr_scp_fadeout(t_all,i)) *
             fm_attributes("nr","foddr")) / fm_attributes("nr","scp");
im_feed_baskets(t_all,i,kap,"foddr") =
               im_feed_baskets(t_all,i,kap,"foddr") * i70_foddr_scp_fadeout(t_all,i);


*** choosing between reginal and global factor requirements
$if "%c70_fac_req_regr%" == "glo" i70_cost_regr(i,kli,"cost_regr_a") = f70_cost_regr(kli,"cost_regr_a");
$if "%c70_fac_req_regr%" == "reg" i70_cost_regr(i,kli,"cost_regr_a") = sum(t_past$(ord(t_past) eq card(t_past)), (f70_hist_factor_costs_livst(t_past,i,kli) / f70_hist_prod_livst(t_past,i,kli,"dm")) - f70_cost_regr(kli,"cost_regr_b") * sum(sys_to_kli(sys,kli),i70_livestock_productivity(t_past,i,sys)));

i70_cost_regr(i,"fish",cost_regr) = f70_cost_regr("fish",cost_regr);
i70_cost_regr(i,kap,"cost_regr_b") = f70_cost_regr(kap,"cost_regr_b");

i70_fac_req_livst(t_all,i,kli) = i70_cost_regr(i,kli,"cost_regr_b") * sum(sys_to_kli(sys,kli), i70_livestock_productivity(t_all,i,sys)) + i70_cost_regr(i,kli,"cost_regr_a");
* use historic livestock factor requirements for t_past if regional switch is on. Once regression has been updated this could also be included for global factor requirements
$if "%c70_fac_req_regr%" == "reg" i70_fac_req_livst(t_all,i,kli)$(m_year(t_all) <= sum(t_past$(ord(t_past) eq card(t_past)), m_year(t_past)) and m_year(t_all) > 1990) = (f70_hist_factor_costs_livst(t_all,i,kli) / f70_hist_prod_livst(t_all,i,kli,"dm"));
