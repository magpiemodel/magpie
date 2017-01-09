*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*consider only afforestation here - deforestation is considered in forest module
p32_min_afforest(t,i) = -fm_forest_change(t,i)*m_yeardiff(t)*f32_afforest_policy(t)*s32_afforest_policy$(fm_forest_change(t,i)<0);

v32_bph_warming_aff.fx(j,"forestry_litc") = 0;
v32_bph_warming_aff.fx(j,"forestry_soilc") = 0;

p32_bgc_cooling_aff_vegc_cum(t,j) = 0;
