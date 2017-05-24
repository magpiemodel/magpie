*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$ifthen "%c33_forest_protection%" == "mixed" i33_fore_protect(t,i) = f33_fore_protect(t,i,"low") * sum(t_to_i_to_dev("y2010",i,dev), sum(scen33_to_dev(scen33,dev), f33_fore_protect_scen(t,scen33)));
$else i33_fore_protect(t,i) = f33_fore_protect(t,i,"low") * f33_fore_protect_scen(t,"%c33_forest_protection%");
$endif

i33_fore_protect(t,i)$(i33_fore_protect(t,i) < 0) = 0;
i33_fore_protect(t,i)$(i33_fore_protect(t,i) > 1) = 1;

p33_land(t,j,ac,when) = 0;
p33_save_forest_shift(t,i) = 0;

