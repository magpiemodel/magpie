*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
parameters

* Population
  im_pop_iso(t,iso)      			population (mio.)
  im_pop(t,i)      					population (mio.)

* GDP in MER
  i09_gdp_mer_iso(t,iso)          	income before a price shock MER (mio. USD)
  i09_gdp_mer(t,i)     	 			income before a price shock MER (mio. USD)

  im_gdp_pc_mer(t,i)              	GDP in market exchange rate per capita (USD)
  i09_gdp_pc_mer_iso(t,iso)         income before a price shock per capita (USD)

* GDP in PPP
  i09_gdp_ppp_iso(t,iso)      		income before a price shock PPP (mio. USD)
  i09_gdp_ppp(t,i)      			income before a price shock PPP (mio. USD)

  im_gdp_pc_ppp(t,i)              	GDP PPP per capita (USD)
  im_gdp_pc_ppp_iso(t,iso)          income PPP before a price shock per capita  (USD)

* Development State
  im_development_state(t,i)  					development state in high income level (1)
  im_physical_inactivity(t,iso,sex,age_group)  	Share of population which is physically inactive (1)
  im_demography(t,iso,sex,age_group) 			Population by groups (mio.)
;