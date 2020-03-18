*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
        s80_maxiter   			maximal solve iterations if modelstat is > 2 (1)    / 30 /
		s80_optfile     		switch to use specfied solver settings (1)          / 0 /
		s80_num_nonopt_allowed 	number of allowed non-optimal variables (1)  		/ Inf /
;

$setglobal c80_nlp_solver  conopt4
*   options:   (conopt3):         conopt3
*              (conopt4):         conopt4
