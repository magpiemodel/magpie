*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* leaching emissions are dynamic with climate for the history;
* for the future, for now we keep them constant at 2010 levels.
if (sum(sameas(t_past,t),1) = 1,
  i51_ef_n_soil(t,i,n_pollutants_direct,emis_source_n_cropsoils51) =
    f51_ef_n_soil(t,i,n_pollutants_direct,emis_source_n_cropsoils51);
else
  i51_ef_n_soil(t,i,n_pollutants_direct,emis_source_n_cropsoils51)=
    i51_ef_n_soil(t-1,i,n_pollutants_direct,emis_source_n_cropsoils51);
);
