*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc44_bii_weighted(j) = 0;
v44_bii_weighted.l(j) = 0.3;
p44_price_bv_loss(t) = f44_price_bv_loss(t,"%c44_price_bv_loss%");

m_linear_interpol(i44_fader,2020,2050,0,1)
display i44_fader;

*** EOF pre.gms ***
