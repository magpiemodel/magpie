*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

ic55_manure_fuel_shr(i,kli)=f55_manure_fuel_shr(t,i,kli,"%c09_gdp_scenario%");

if(m_year(t) <= 2015,
 ic55_awms_shr(i,kli,awms_conf) = f55_awms_shr(t,i,"ssp2",kli,awms_conf);
else
 ic55_awms_shr(i,kli,awms_conf) = f55_awms_shr(t,i,"%c55_scen_conf%",kli,awms_conf);
);
