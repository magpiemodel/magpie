*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  scen12 Interest rate scenarios
  / low, medium, high /

	bound12 Bound for interest rate
	/ low, high/

  scen12_to_dev(scen12,dev) Mapping between interest scneario and economic development status
  /       high        . (lic)
          medium      . (mic)
          low         . (hic) /

  t_to_i_to_dev(t_all,i,dev) Mapping between time region and economic development status
;
