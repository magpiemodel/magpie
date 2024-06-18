*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Region price share for 2nd generation bioenergy demand scenario:
* Country switch to determine countries for which scenario shall be applied.
* In the default case, the selected scneario (c60_2ndgen_biodem) affects
* all countries.
p60_country_dummy(iso) = 0;
p60_country_dummy(scen_countries60) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by their population size.
p60_region_BE_shr(t_all,i) = sum(i_to_iso(i,iso), p60_country_dummy(iso) * im_pop_iso(t_all,iso)) / sum(i_to_iso(i,iso), im_pop_iso(t_all,iso));

$ifthen "%c60_2ndgen_biodem%" == "coupling"
  i60_bioenergy_dem(t,i) = f60_bioenergy_dem_coupling(t,i);
$elseif "%c60_2ndgen_biodem%" == "emulator"
  i60_bioenergy_dem(t,i) = f60_bioenergy_dem_emulator(t)/card(i);
$elseif "%c60_2ndgen_biodem%" == "none"
  i60_bioenergy_dem(t,i) = 0;
** Harmonize till 2020 if not coupled or emulator 
loop(t$(m_year(t) <= sm_fix_SSP2),
  i60_bioenergy_dem(t,i) = f60_bioenergy_dem(t,i,"R32M46-SSP2EU-NPi");
);
$else
  i60_bioenergy_dem(t,i) = f60_bioenergy_dem(t,i,"%c60_2ndgen_biodem%") * p60_region_BE_shr(t,i)
                         + f60_bioenergy_dem(t,i,"%c60_2ndgen_biodem_noselect%") * (1-p60_region_BE_shr(t,i));
** Harmonize till 2020 if not coupled or emulator 
loop(t$(m_year(t) <= sm_fix_SSP2),
  i60_bioenergy_dem(t,i) = f60_bioenergy_dem(t,i,"R32M46-SSP2EU-NPi");
);
$endif
