*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de




i20_scp_type_shr(scptype) = f20_scp_type_shr(scptype,"%c20_scp_type%");
i20_processing_conversion_factors(t_all,processing20,ksd,kpr) = f20_processing_conversion_factors(t_all,processing20,ksd,kpr);
i20_processing_shares(t_all,i,ksd,kpr) = f20_processing_shares(t_all,i,ksd,kpr);
i20_processing_unitcosts(ksd,kpr) = f20_processing_unitcosts(ksd,kpr);

i20_scp_conversion_factors(kpr) = sum(scptype,i20_scp_type_shr(scptype)*f20_scp_conversionmatrix(kpr,scptype));
i20_processing_conversion_factors(t,"breeding","scp",kpr) = i20_scp_conversion_factors(kpr);
i20_processing_shares(t_all,i,"scp",kpr) = 0;
i20_processing_shares(t_all,i,"scp",kpr)$(i20_scp_conversion_factors(kpr) > 0) = 1;
i20_processing_unitcosts("scp",kpr) = sum(scptype, i20_scp_type_shr(scptype) * f20_scp_unitcosts(scptype));
