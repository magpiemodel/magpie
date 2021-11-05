*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i39_cost_establish(t,i,land) = 0;
i39_reward_reduction(t,i,land) = 0;

i39_cost_clearing(land) = 0;
i39_cost_clearing(land_clearing39) = s39_cost_clearing;

i39_calib(i,type39) = f39_calib(i,type39);
* set calibration factor to 1 in case of missing input file
i39_calib(i,type39)$(i39_calib(i,type39) = 0) = 1;
* set calibration factor to 1 depending on s39_ignore_calib
i39_calib(i,type39)$(s39_ignore_calib = 1) = 1;


display i39_calib;
