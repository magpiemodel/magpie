*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i39_cost_establish(t,i,land) = 0;
i39_reward_reduction(t,i,land) = 0;

i39_calib(t,i,type39) = f39_calib(t,i,type39);
* set default values in case of missing input file or s39_ignore_calib = 1
if(sum((t,i,type39),i39_calib(t,i,type39)) = 0 OR s39_ignore_calib = 1,
  i39_calib(t,i,"cost") = 1;
  i39_calib(t,i,"reward") = 0;
);
