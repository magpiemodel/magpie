*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*' @code
*' In MAgPIE we model only 50 percent of the projected woodfuel demand.
*' Similar to the assumption by IMAGE model. See Lauri et al. 2019 for validation.
*' Not all wood involved is produced from formal forestry activities, as it is also
*' collected from non-forest areas, for example from thinning orchards and along
*' roadsides (FAO, 2001; FAO, 2008). As few reliable data are available on fuelwood
*' production, We make an assumption similar to IMAGE. While fuelwood production in
*' industrialized regions is dominated by large-scale, commercial operations, in
*' transitional and developing regions smaller proportions of fuelwood volumes are
*' assumed to come from forestry operations: 50% and 32% respectively.
*' In MAgPIE, we assume 50% value across the board.

fm_forestry_demand(t,i,"wood") = 103 + 0.4e-05  * im_gdp_pc_ppp(t,i) * im_pop(t,i) ;
fm_forestry_demand(t,i,"woodfuel") = 70 + 0.8e-05  * im_gdp_pc_ppp(t,i);
*fm_forestry_demand(t_all,i,kforestry) = f16_forestry_demand(t_all,i,kforestry);
fm_forestry_demand(t,i,"woodfuel") = (fm_forestry_demand(t,i,"woodfuel") * 0.33)$(im_development_state(t,i)<0.33) + (fm_forestry_demand(t,i,"woodfuel") * 0.50)$(im_development_state(t,i)>=0.33 AND im_development_state(t,i)<0.66) + (fm_forestry_demand(t,i,"woodfuel"))$(im_development_state(t,i)>=0.66);
*fm_forestry_demand(t,i,"woodfuel") = (f16_forestry_demand(t,i,"woodfuel") * 0.33)$(im_development_state(t,i)<0.33) + (f16_forestry_demand(t,i,"woodfuel") * 0.50)$(im_development_state(t,i)>=0.33 AND im_development_state(t,i)<0.66) + (f16_forestry_demand(t,i,"woodfuel"))$(im_development_state(t,i)>=0.66);

f16_FAO_timber_demand(t,kforestry) = sum((i),f16_forestry_demand(t,i,kforestry));
f16_glo_timber_demand(t,kforestry) = sum((i),fm_forestry_demand(t,i,kforestry));
display f16_FAO_timber_demand,f16_glo_timber_demand;
*' @stop
