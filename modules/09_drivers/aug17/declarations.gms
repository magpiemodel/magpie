*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de
parameters

* Population
  im_pop_iso(t,iso)      			population (Mio people)
  im_pop(t,i)      					population (Mio people)

* GDP in MER
  i09_gdp_mer_iso(t,iso)          	income (Mio USD05 MER before a price shock)
  i09_gdp_mer(t,i)     	 			income (Mio USD05 MER before a price shock)

  im_gdp_pc_mer(t,i)              	GDP per capita (USD05 in market exchange rate per capita)
  i09_gdp_pc_mer_iso(t,iso)         income per capita (USD05 MER before a price shock per capita)

* GDP in PPP
  i09_gdp_ppp_iso(t,iso)      		income (Mio USD05 PPP before a price shock)
  i09_gdp_ppp(t,i)      			income (Mio USD05 PPP before a price shock)

  im_gdp_pc_ppp(t,i)              	GDP per capita (USD05 PPP)
  im_gdp_pc_ppp_iso(t,iso)          income per capita (USD05 PPP per capita before a price shock)

* Development State
  im_development_state(t,i)  					development state (share in high income level)
  im_physical_inactivity(t,iso,sex,age_group)  	Share of population which is physically inactive (people per people)
  im_demography(t,iso,sex,age_group) 			Population by groups (Mio people)
;