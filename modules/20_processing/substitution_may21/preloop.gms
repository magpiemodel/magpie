*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


i20_processing_conversion_factors(t_all,processing20,ksd,kpr) = f20_processing_conversion_factors(t_all,processing20,ksd,kpr);
i20_processing_shares(t_all,i,ksd,kpr) = f20_processing_shares(t_all,i,ksd,kpr);
i20_processing_unitcosts(ksd,kpr) = f20_processing_unitcosts(ksd,kpr);

*Costs for single-cell protein production (scp) are accounted for separately in f20_scp_unitcosts (see 'q20_processing_costs').
*Separate accounting is needed because scp_hydrogen has no land requirements, and thus otherwise would have no costs.
*To avoid double accounting the processing costs of scp_methane, scp_sugar and scp_cellulose are set to zero.
i20_processing_unitcosts("scp",kpr) = 0;

*SCP can be produced via different routes. The processing shares for SCP are scenario dependent (c20_scp_type). 
i20_processing_shares(t_all,i,"scp",kpr) = 0;
i20_processing_shares(t_all,i,"scp",kpr) = f20_scp_processing_shares(kpr,"%c20_scp_type%");
