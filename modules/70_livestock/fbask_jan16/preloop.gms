*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
loop(t_all,
 if(m_year(t_all) <= sm_fix_SSP2,
  im_slaughter_feed_share(t_all,i,kap,attributes) = f70_slaughter_feed_share(t_all,i,kap,attributes,"ssp2");
  i70_livestock_productivity(t_all,i,sys) = f70_livestock_productivity(t_all,i,sys,"ssp2");
  im_feed_baskets(t_all,i,kap,kall) = f70_feed_baskets(t_all,i,kap,kall,"ssp2");
 else
  im_slaughter_feed_share(t_all,i,kap,attributes) = f70_slaughter_feed_share(t_all,i,kap,attributes,"%c70_feed_scen%");
  i70_livestock_productivity(t_all,i,sys) = f70_livestock_productivity(t_all,i,sys,"%c70_feed_scen%");
  im_feed_baskets(t_all,i,kap,kall) = f70_feed_baskets(t_all,i,kap,kall,"%c70_feed_scen%");
  im_feed_baskets(t_all,i,kap,k) = im_feed_baskets(t_all,i,kap,k)*(1-s70_scp_shr);
  im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp") + sum(k, im_feed_baskets(t_all,i,kap,k))*s70_scp_shr;
 );
);
