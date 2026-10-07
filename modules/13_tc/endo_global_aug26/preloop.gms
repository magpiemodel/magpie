*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

loop(t,
 if(m_year(t) <= sm_fix_SSP2,
  i13_tc_factor(t) = f13_tc_factor(t,"medium");
  i13_tc_exponent(t) = f13_tc_exponent(t,"medium");
 else
  i13_tc_factor(t) = f13_tc_factor(t,"%c13_tccost%");
  i13_tc_exponent(t) = f13_tc_exponent(t,"%c13_tccost%");
 );
);

pc13_tau(h,"crop")        = fm_tau1995(h);
pc13_tau(h,"pastr")       = f13_pastr_tau_hist("y1995",h);
pc13_tcguess(h,tautype)   = f13_tcguess(h);


* Country switch to determine countries for which certain policies shall be applied.
* In the default case, the policy affects all countries when activated.
p13_country_switch(iso) = 0;
p13_country_switch(croparea_consv_countries13) = 1;

** Trajectory for implementation of croparea conservation
* sigmoidal interpolation between 2020 and target year
m_sigmoid_time_interpol(i13_croparea_consv_fader,s13_croparea_consv_start,s13_croparea_consv_target,0,1);

m_sigmoid_time_interpol(i13_tau_croparea_consv_fader,s13_croparea_consv_start,s13_croparea_consv_target,1,s13_croparea_consv_tau_factor);

pc13_land(i,"pastr") = sum(cell(i,j),pcm_land(j,"past"));
pc13_land(i,"crop") = sum(cell(i,j),pcm_land(j,"crop"));

* Positive lower bound is needed since tau**exponent shouldn't encounter tau = 0.
v13_tau_init.lo(t_past, h) = 0.1;
v13_rd_investment_init.fx(t_past, i)$(sum(supreg(h,i), f13_tau_historical(t_past, h)) = 0) = 0;

solve m13_rd_stock_init USING nlp MINIMIZING v13_init_approximation_error;

* Display reconstructed tau and initial R&D stock in full.lst
display "R&D Stock Initialization run finished with modelstat ";
display m13_rd_stock_init.modelstat;
display "Reconstructed tau in historical period ";
display v13_tau_init.l;
display "Initial R&D Stock ";
display v13_rd_stock_per_area_init.l;
display "Reconstructed investments in historical period ";
display v13_rd_investment_init.l;

if(m13_rd_stock_init.modelstat > 2 AND m13_rd_stock_init.modelstat ne 7,
  m13_rd_stock_init.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "R&D Stock initialization Model became infeasible already during initialisation run. Stop run.";
);

* Use the result from the `m13_rd_stock_init` model to initialize the R&D stock.
p13_rd_stock_per_area(t_all, i, "crop") = v13_rd_stock_per_area_init.l(t_all, i);
