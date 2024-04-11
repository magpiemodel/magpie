*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
  p80_modelstat(t,h)  modelstat indicator (1)
  p80_counter(h)      counter (1)
  p80_handle(h)       parallel mode handle parameter (1)
;

scalars
  s80_counter           counter (1)
  s80_modelstat_previter  modelstat of previous iteration (1)
  s80_optfile_previter    optfile used in previous iteration (1)
  s80_resolve           indicator for restarting solve (1)
;
