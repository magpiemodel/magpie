*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

scalars
        s80_maxiter   maximal solve iterations if modelstat is > 2 (1)    / 30 /
		s80_optfile     switch to use specfied solver settings (1)          / 1 /
		s80_add_cplex   add cplex optimization after conopt4 (1)            / 0 /
        s80_add_conopt3 add conopt3 optimization after conopt4 (1)          / 0 /
;


$setglobal c80_nlp_solver  conopt4+conopt3
*   options:   (conopt3):         conopt3
*              (conopt4):         conopt4
*              (conopt4+cplex):   conopt4 followed by cplex with landdiff optimization 
*              (conopt4+conopt3): conopt4 followed by conopt3

