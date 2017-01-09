*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de


m_annuity_costs_update(p39_cost_landcon_past(t2,j,land), v39_cost_landcon_annuity.l(j,land), sm_invest_horizon)



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_landcon(t,j,land,"marginal")           = vm_cost_landcon.m(j,land);
 ov39_cost_landcon_annuity(t,j,land,"marginal") = v39_cost_landcon_annuity.m(j,land);
 oq39_cost_landcon_annuity(t,j,land,"marginal") = q39_cost_landcon_annuity.m(j,land);
 oq39_cost_landcon(t,j,land,"marginal")         = q39_cost_landcon.m(j,land);
 ov_cost_landcon(t,j,land,"level")              = vm_cost_landcon.l(j,land);
 ov39_cost_landcon_annuity(t,j,land,"level")    = v39_cost_landcon_annuity.l(j,land);
 oq39_cost_landcon_annuity(t,j,land,"level")    = q39_cost_landcon_annuity.l(j,land);
 oq39_cost_landcon(t,j,land,"level")            = q39_cost_landcon.l(j,land);
 ov_cost_landcon(t,j,land,"upper")              = vm_cost_landcon.up(j,land);
 ov39_cost_landcon_annuity(t,j,land,"upper")    = v39_cost_landcon_annuity.up(j,land);
 oq39_cost_landcon_annuity(t,j,land,"upper")    = q39_cost_landcon_annuity.up(j,land);
 oq39_cost_landcon(t,j,land,"upper")            = q39_cost_landcon.up(j,land);
 ov_cost_landcon(t,j,land,"lower")              = vm_cost_landcon.lo(j,land);
 ov39_cost_landcon_annuity(t,j,land,"lower")    = v39_cost_landcon_annuity.lo(j,land);
 oq39_cost_landcon_annuity(t,j,land,"lower")    = q39_cost_landcon_annuity.lo(j,land);
 oq39_cost_landcon(t,j,land,"lower")            = q39_cost_landcon.lo(j,land);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
