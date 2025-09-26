*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc13_land(i,"pastr") = sum(cell(i,j),pcm_land(j,"past"));
pc13_land(i,"crop") = sum(cell(i,j),pcm_land(j,"crop"));

*** Share of cropland within conservation priority area
p13_cropland_consv_shr(t,j) = 0;

if(c13_croparea_consv = 1,
* the cropland area within conservation priority areas is provided by the interface `pm_land_conservation`
  p13_cropland_consv_shr(t,j)$(pcm_land(j,"crop") > 0) = sum(consv_type, pm_land_conservation(t,j,"crop",consv_type))/pcm_land(j,"crop");
  p13_cropland_consv_shr(t,j)$(p13_cropland_consv_shr(t,j) > 1) = 1;

* The following lines allow to freely chose a given share of the total cropland
* area that should be subject to conservation management with a lower land use intensity.
  if(s13_croparea_consv_shr > 0 AND m_year(t) >= s13_croparea_consv_start,
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by available cropland area.
    p13_country_weight(i) = sum(i_to_iso(i,iso), p13_country_switch(iso) * pm_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), pm_avl_cropland_iso(iso));
    p13_cropland_consv_shr(t,j) = i13_croparea_consv_fader(t) *
    (s13_croparea_consv_shr * sum(cell(i,j), p13_country_weight(i))
    + s13_croparea_consv_shr_noselect * sum(cell(i,j), 1-p13_country_weight(i)));

  );

);

* ISO country weights are calculated based on the available cropland area in each country
p13_country_wght_supreg(h) = sum((i_to_iso(i,iso), supreg(h,i)), p13_country_switch(iso) * pm_avl_cropland_iso(iso)) / sum((i_to_iso(i,iso), supreg(h,i)), pm_avl_cropland_iso(iso));

* Country-weighted tau reduction factor for conservation land
p13_croparea_consv_tau_factor(h) = (s13_croparea_consv_tau_factor * p13_country_wght_supreg(h)
                            + s13_croparea_consv_tau_factor_noselect * (1-p13_country_wght_supreg(h)));


if (smin((h,tautype), f13_tau_scenario(t,h,tautype)) <= 0,
  abort "tau value of 0 detected in at least one region!";
);

p13_tau_core(h,tautype) = f13_tau_scenario(t,h,tautype);

* p13_tau_consv is linked to p13_tau_core through the
* reduction factor for conservation land
if (c13_croparea_consv_tau_increase = 1 OR m_year(t) < s13_croparea_consv_start,
  p13_tau_consv(h,tautype) = p13_croparea_consv_tau_factor(h) * f13_tau_scenario(t,h,tautype);
  pc13_tau_consv(h,tautype) = p13_tau_consv(h,tautype);
elseif c13_croparea_consv_tau_increase = 0 AND m_year(t) >= s13_croparea_consv_start,
  p13_tau_consv(h,tautype) = pc13_tau_consv(h,tautype);
);

* The overall land use intensity factor `vm_tau` is a linear combination between the
* land use intensity factors `p13_tau` for regular cropland and `p13_tau_consv`
* for cropland in conservation priority areas.

vm_tau.fx(j,tautype) = sum((cell(i,j), supreg(h,i)), (1-p13_cropland_consv_shr(t,j)) * p13_tau_core(h,tautype) + p13_cropland_consv_shr(t,j) * p13_tau_consv(h,tautype));

* The costs are shifted over 15 years (exponent 15) to reflect the average
* time it takes investments in tc to pay off.

p13_cost_tc(i,tautype) = pc13_land(i,tautype) * i13_tc_factor(t)
                     * sum(supreg(h,i), p13_tau_core(h,tautype))**i13_tc_exponent(t)
                     * (1+pm_interest(t,i))**15;

p13_tech_cost(i,tautype) = (sum(supreg(h,i),p13_tau_core(h,tautype)/pc13_tau(h,tautype))-1) * p13_cost_tc(i,tautype)
                               * pm_interest(t,i)/(1+pm_interest(t,i));

vm_tech_cost.fx(i) = sum(tautype, p13_tech_cost(i,tautype));

if(ord(t) = 1,
  pc13_tau_consv(h,tautype) = p13_croparea_consv_tau_factor(h) * pc13_tau(h,"crop");
  pcm_tau(j,tautype) = sum((cell(i,j), supreg(h,i)), (1-p13_cropland_consv_shr(t,j)) * pc13_tau(h,tautype) + p13_cropland_consv_shr(t,j) * pc13_tau_consv(h,tautype));
);
