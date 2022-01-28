*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
parameters

* Population
  im_pop_iso(t_all,iso)                              Population (mio. per yr)
  im_pop(t_all,i)                                    Population (mio. per yr)

* GDP in MER
  i09_gdp_mer_iso(t_all,iso)                  Income in market exchange rates (mio. USD05MER per yr)
  i09_gdp_mer(t_all,i)                        Income in market exchange rates (mio. USD05MER per yr)

  im_gdp_pc_mer(t_all,i)                Per capita income in market exchange rates (USD05MER per cap per yr)
  i09_gdp_pc_mer_iso(t_all,iso)         Per capita income in market exchange rates (USD05MER per cap per yr)

* GDP in PPP
  i09_gdp_ppp_iso(t_all,iso)                      Income in purchasing power parity (mio. USD05PPP per yr)
  i09_gdp_ppp(t_all,i)                            Income in purchasing power parity (mio. USD05PPP per yr)

  i09_gdp_pc_ppp(t_all,i)                Per capita income in purchasing power parity (USD05PPP per cap per yr)
  im_gdp_pc_ppp_iso(t_all,iso)          Per capita income in purchasing power parity (USD05PPP per cap per yr)

* Development State
  im_development_state(t_all,i)                  Development state according to the World Bank definition where 0=low income country 1=high income country in high income level  (1)
  im_physical_inactivity(t_all,iso,sex,age)          Share of population which is physically inactive (1)
  im_demography(t_all,iso,sex,age)                   Population by groups (mio. per yr)

* Years where SSPs and nocc/cc scenarios diverge 
  sm_fix_SSP2			        	year until which all parameters are fixed to SSP2 values (year) / 2020 /
  sm_fix_cc				          year until which all parameters affected by cc are fixed to historical values (year) / 2020 /
;
