*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

scalars
    s80_maxiter   maximal solve iterations if modelstat is > 2 (1)      / 30 /
    s80_optfile     switch to use specfied solver settings (1)          / 0 /
    s80_add_cplex   add cplex optimization after conopt4 (1)            / 0 /
    s80_add_conopt3 add conopt3 optimization after conopt4 (1)          / 0 /
    s80_secondsolve     second solve statement (binary)                 / 0 / 
;


$setglobal c80_nlp_solver  conopt4
*   options:   (conopt3):         conopt3
*              (conopt4):         conopt4
*              (conopt4+cplex):   conopt4 followed by cplex with landdiff optimization
*              (conopt4+conopt3): conopt4 followed by conopt3
