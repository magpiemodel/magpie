*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
        s80_maxiter   maximal solve iterations if modelstat is > 2 (1)    / 30 /
		s80_optfile     switch to use specfied solver settings (1)          / 0 /
;

$setglobal c80_nlp_solver  conopt4
*   options:   (conopt3):         conopt3
*              (conopt4):         conopt4
