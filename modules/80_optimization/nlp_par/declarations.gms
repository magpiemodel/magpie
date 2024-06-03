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
  p80_extra_solve(h)  indicator for extra solve (1)
  p80_counter_modelstat(h)   counter for modelstat <= 2 (1)
  p80_resolve_option(h)      option for resolve (1)
;

scalars
  s80_counter             counter (1)
  s80_resolve_option      option for resolve (1)
;
