*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
parameters

* Population
  im_pop_iso(t,iso)                              Population (mio. per yr)
  im_pop(t,i)                                              Population (mio. per yr)

* GDP in MER
  i09_gdp_mer_iso(t,iso)                  Income in market exchange rates (mio. USD05MER per yr)
  i09_gdp_mer(t,i)                                      Income in market exchange rates (mio. USD05MER per yr)

  im_gdp_pc_mer(t,i)                      Per capita income in market exchange rates (USD05MER per cap per yr)
  i09_gdp_pc_mer_iso(t,iso)         Per capita income in market exchange rates (USD05MER per cap per yr)

* GDP in PPP
  i09_gdp_ppp_iso(t,iso)                      Income in purchasing power parity (mio. USD05PPP per yr)
  i09_gdp_ppp(t,i)                              Income in purchasing power parity (mio. USD05PPP per yr)

  im_gdp_pc_ppp(t,i)                      Per capita income in purchasing power parity (USD05PPP per cap per yr)
  im_gdp_pc_ppp_iso(t,iso)          Per capita income in purchasing power parity (USD05PPP per cap per yr)

* Development State
  im_development_state(t,i)                          Development state according to the World Bank definition where 0=low income country 1=high income country in high income level  (1)
  im_physical_inactivity(t,iso,sex,age)          Share of population which is physically inactive (1)
  im_demography(t,iso,sex,age)                         Population by groups (mio. per yr)
;