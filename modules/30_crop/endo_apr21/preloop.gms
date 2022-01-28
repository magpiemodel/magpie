*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*due to some rounding errors the input data currently may contain in some cases
*very small, negative numbers. These numbers have to be set to 0 as area
*cannot be smaller than 0!
fm_croparea(t_past,j,w,kcr)$(fm_croparea(t_past,j,w,kcr)<0) = 0;

****** Regional share of Set aside cropland policy in selective countries:
* Country switch to determine countries for which a set aside cropland policy shall be applied.
* In the default case, the set aside cropland policy affects all countries when activated.
p30_country_dummy(iso) = 0;
p30_country_dummy(policy_countries30) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by available cropland area.
i30_avl_cropland_iso(iso) = f30_avl_cropland_iso(iso,"%c30_marginal_land%");
p30_region_setaside_shr(i) = sum(i_to_iso(i,iso), p30_country_dummy(iso) * i30_avl_cropland_iso(iso)) / sum(i_to_iso(i,iso), i30_avl_cropland_iso(iso));
