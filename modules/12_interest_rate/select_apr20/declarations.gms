*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 pm_interest(t_all,i)               Interest rate in each region and timestep (% per yr)
* country-specific region scenario switch
 p12_country_dummy(iso)              Dummy parameter indicating whether country is affected by interest rate scenario (1)
 p12_reg_shr(t_all,i)                Weighted share of region with regards to interest rate scenario of countries (1)
;
