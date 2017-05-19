*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$ifthen "%c33_forest_protection%" == "mixed" i33_fore_protect(t,i) = f33_fore_protect(t,i,"low") * sum(t_to_i_to_dev("y2010",i,dev), sum(scen33_to_dev(scen33,dev), f33_fore_protect_scen(t,scen33)));
$else i33_fore_protect(t,i) = f33_fore_protect(t,i,"low") * f33_fore_protect_scen(t,"%c33_forest_protection%");
$endif

i33_fore_protect(t,i)$(i33_fore_protect(t,i) < 0) = 0;
i33_fore_protect(t,i)$(i33_fore_protect(t,i) > 1 - f33_save_fore_prod(i)) = 1 - f33_save_fore_prod(i);

i33_save_fore_protect(t,i,"ifft") = s33_save_ifft*i33_fore_protect(t,i);
i33_save_fore_protect(t,i,"modnat") = (1-s33_save_ifft)*i33_fore_protect(t,i);

p33_land(t,j,ac,land33,si,when) = 0;
p33_save_forest_shift(t,i,land33) = 0;

f33_ifft(j,si)$(f33_ifft(j,si) > pcm_land(j,"forest",si)) = pcm_land(j,"forest",si);

i33_land(j,ac,land33,si) = 0;
i33_land(j,"acx","ifft",si) = 0 + f33_ifft(j,si)$(fm_carbon_density("y1995",j,"forest","vegc") > 20);
i33_land(j,"acx","modnat",si) = pcm_land(j,"forest",si) - i33_land(j,"acx","ifft",si);

*consider only deforestation here - afforestation is considered in forestry module
p33_max_deforest(t,i) = Inf;
p33_max_deforest(t,i)$(f33_deforest_policy(t) < Inf) =
                fm_forest_change(t,i)*f33_deforest_policy(t)*s33_deforest_policy$(fm_forest_change(t,i)>0);
