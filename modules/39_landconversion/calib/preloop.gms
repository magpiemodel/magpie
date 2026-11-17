*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i39_cost_establish(t,i,land) = 0;
i39_reward_reduction(t,i,land) = 0;

* The calibration files contain calibration factors for the historical period only.
* Values for later years (e.g. in calibration files from older model versions) are ignored.
s39_hist_end_year = smax(t_past, m_year(t_past));

*** Cropland
i39_calib(t,i,type39)$(m_year(t) <= s39_hist_end_year) = f39_calib(t,i,type39);
* set default values in case of missing input file or s39_ignore_calib = 1
if(sum((t_all,i,type39),f39_calib(t_all,i,type39)) = 0 OR s39_ignore_calib = 1,
  i39_calib(t,i,"cost") = 1;
  i39_calib(t,i,"reward") = 0;
else
  i39_calib_hist_end(i,type39) = sum(t_past$(m_year(t_past) = s39_hist_end_year), f39_calib(t_past,i,type39));
  abort$(sum(i, i39_calib_hist_end(i,"cost")) = 0) "f39_calib.csv contains no calibration factors for the last year of t_past (see c_past). Recalibrate the land conversion costs or choose a matching c_past.", s39_hist_end_year;
  abort$(s39_convergence_year <= s39_hist_end_year) "s39_convergence_year has to be later than the last year of t_past.", s39_convergence_year, s39_hist_end_year;
* Share of the way from the last historical calibration factor to the neutral value:
* 0 in the last historical year, rising linearly to 1 in s39_convergence_year.
  m_linear_time_interpol(i39_calib_fader,s39_hist_end_year,s39_convergence_year,0,1);
* Cost calibration factors below 1 move up to 1 if s39_expansioncost_upwards_convergence = 1,
* factors above 1 move down to 1 if s39_expansioncost_downwards_convergence = 1,
* otherwise they keep the value of the last historical year.
  i39_calib(t,i,"cost")$(m_year(t) > s39_hist_end_year) =
      i39_calib_hist_end(i,"cost")
    + (1 - i39_calib_hist_end(i,"cost")) * i39_calib_fader(t)
      * (s39_expansioncost_upwards_convergence$(i39_calib_hist_end(i,"cost") < 1)
       + s39_expansioncost_downwards_convergence$(i39_calib_hist_end(i,"cost") > 1));
* Reward calibration factors move down to 0 if s39_contractionreward_downwards_convergence = 1,
* otherwise they keep the value of the last historical year.
  i39_calib(t,i,"reward")$(m_year(t) > s39_hist_end_year) =
      i39_calib_hist_end(i,"reward") * (1 - s39_contractionreward_downwards_convergence * i39_calib_fader(t));
);

*** Pasture
i39_calib_past(t,i,type39)$(m_year(t) <= s39_hist_end_year) = f39_calib_past(t,i,type39);
* set default values in case of missing input file or s39_ignore_calib_past = 1
if(sum((t_all,i,type39),f39_calib_past(t_all,i,type39)) = 0 OR s39_ignore_calib_past = 1,
  i39_calib_past(t,i,"cost") = 1;
  i39_calib_past(t,i,"reward") = 0;
else
  i39_calib_hist_end_past(i,type39) = sum(t_past$(m_year(t_past) = s39_hist_end_year), f39_calib_past(t_past,i,type39));
  abort$(sum(i, i39_calib_hist_end_past(i,"cost")) = 0) "f39_calib_past.csv contains no calibration factors for the last year of t_past (see c_past). Recalibrate the land conversion costs or choose a matching c_past.", s39_hist_end_year;
  abort$(s39_convergence_year_past <= s39_hist_end_year) "s39_convergence_year_past has to be later than the last year of t_past.", s39_convergence_year_past, s39_hist_end_year;
  m_linear_time_interpol(i39_calib_fader_past,s39_hist_end_year,s39_convergence_year_past,0,1);
  i39_calib_past(t,i,"cost")$(m_year(t) > s39_hist_end_year) =
      i39_calib_hist_end_past(i,"cost")
    + (1 - i39_calib_hist_end_past(i,"cost")) * i39_calib_fader_past(t)
      * (s39_expansioncost_upwards_convergence_past$(i39_calib_hist_end_past(i,"cost") < 1)
       + s39_expansioncost_downwards_convergence_past$(i39_calib_hist_end_past(i,"cost") > 1));
  i39_calib_past(t,i,"reward")$(m_year(t) > s39_hist_end_year) =
      i39_calib_hist_end_past(i,"reward") * (1 - s39_contractionreward_downwards_convergence_past * i39_calib_fader_past(t));
);
