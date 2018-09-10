*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
parameters

* Population
  im_pop_iso(t,iso)      			Population (mio. per yr)
  im_pop(t,i)      					Population (mio. per yr)

* GDP in MER
  i09_gdp_mer_iso(t,iso)          	Income before a price shock (mio. USD05MER per yr)
  i09_gdp_mer(t,i)     	 			Income before a price shock (mio. USD05MER per yr)

  im_gdp_pc_mer(t,i)              	GDP per capita (USD05MER per yr)
  i09_gdp_pc_mer_iso(t,iso)         Income before a price shock per capita (USD05MER per yr)

* GDP in PPP
  i09_gdp_ppp_iso(t,iso)      		Income before a price shock (mio. USD05PPP per yr)
  i09_gdp_ppp(t,i)      			Income before a price shock (mio. USD05PPP per yr)

  im_gdp_pc_ppp(t,i)              	GDP per capita (USD05PPP per yr)
  im_gdp_pc_ppp_iso(t,iso)          Income before a price shock per capita  (USD05PPP per yr)

* Development State
  im_development_state(t,i)  					Development state depending on income level (1)
  im_physical_inactivity(t,iso,sex,age)  		Share of population which is physically inactive (1)
  im_demography(t,iso,sex,age) 					Population by groups (mio. per yr)
;