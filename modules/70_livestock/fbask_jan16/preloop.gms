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
 );
);

i70_feed_fadeout(t_all)$(m_year(t_all) <= 2020) = 1;
i70_feed_fadeout("y2025") = 0.8333;
i70_feed_fadeout("y2030") = 0.6667;
i70_feed_fadeout("y2035") = 0.5;
i70_feed_fadeout("y2040") = 0.3333;
i70_feed_fadeout("y2045") = 0.1667;
i70_feed_fadeout(t_all)$(m_year(t_all) >= 2050) = 0;

loop(t_all$(m_year(t_all) > 2020),
if(s70_scp_feed = 1,
*convert from DM to Nr
im_feed_baskets(t_all,i,kap,kall70) = im_feed_baskets(t_all,i,kap,kall70)*fm_attributes("nr",kall70);
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")*fm_attributes("nr","scp");
*replace feed with SCP based on Nr
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")
             + sum(kall70, im_feed_baskets(t_all,i,kap,kall70) * (1-i70_feed_fadeout(t_all)));
im_feed_baskets(t_all,i,kap,kall70) =
               im_feed_baskets(t_all,i,kap,kall70) * i70_feed_fadeout(t_all);
*convert back from Nr to DM
im_feed_baskets(t_all,i,kap,kall70) = im_feed_baskets(t_all,i,kap,kall70)/fm_attributes("nr",kall70);
im_feed_baskets(t_all,i,kap,"scp") = im_feed_baskets(t_all,i,kap,"scp")/fm_attributes("nr","scp");
);
);