** Weighting future rotation calculation for mean regional values by area
pm_rotation_reg(t,i) = ord(t) + ceil((sum(cell(i,j),pcm_land(j,"forestry")*pm_rot_length_estb(t,j))/sum(cell(i,j),pcm_land(j,"forestry")))/5) + card(t_past_ff);
*pm_rotation_reg(t,i) = ord(t) + ceil(30/5) + card(t_past_ff);

i21_demand_forestry_future(i,kforestry)    = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),p21_demand_ext(t_ext,i,kforestry));
i21_selfsuff_forestry_future(i,kforestry)  = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),p21_selfsuff_ext(t_ext,i,kforestry));
i21_trade_bal_reduction_future(kforestry)  = sum(t_ext, i21_trade_bal_reduction_ff(t_ext,kforestry))/card(t_ext);
i21_trade_balanceflow_future(kforestry)    = sum(t_ext, p21_trade_balanceflow_ext(t_ext,kforestry))/card(t_ext);
i21_exp_shr_future(i,kforestry)            = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),p21_exp_shr_ext(t_ext,i,kforestry));
pcm_production_ratio_future(i)             = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),pm_production_ratio_ext(t_ext,i));

*************** Forestry Stuff

i21_excess_dem_ff(kforestry) = sum(i, i21_demand_forestry_future(i,kforestry)*(1 - i21_selfsuff_forestry_future(i,kforestry))$(i21_selfsuff_forestry_future(i,kforestry) < 1)) + i21_trade_balanceflow_future(kforestry);

i21_excess_prod_ff(i,kforestry) = i21_excess_dem_ff(kforestry)*i21_exp_shr_future(i,kforestry);

i21_excess_prod_ff(i,kforestry) = i21_demand_forestry_future(i,kforestry)*(1 - i21_selfsuff_forestry_future(i,kforestry))$(i21_selfsuff_forestry_future(i,kforestry) < 1) + i21_trade_balanceflow_future(kforestry) * i21_exp_shr_future(i,kforestry);


vm_prod_future_reg_ff.lo(i,kforestry) = (i21_demand_forestry_future(i,kforestry) + i21_excess_prod_ff(i,kforestry)) * i21_trade_bal_reduction_future(kforestry)$(i21_selfsuff_forestry_future(i,kforestry) >= 1) + i21_demand_forestry_future(i,kforestry) * i21_selfsuff_forestry_future(i,kforestry) * i21_trade_bal_reduction_future(kforestry)$(i21_selfsuff_forestry_future(i,kforestry) < 1);

vm_prod_future_reg_ff.up(i,kforestry) = ((i21_demand_forestry_future(i,kforestry) + i21_excess_prod_ff(i,kforestry))/ i21_trade_bal_reduction_future(kforestry))$(i21_selfsuff_forestry_future(i,kforestry) >= 1) + (i21_demand_forestry_future(i,kforestry)*i21_selfsuff_forestry_future(i,kforestry)/i21_trade_bal_reduction_future(kforestry))$(i21_selfsuff_forestry_future(i,kforestry) < 1);

p21_prod_future_reg_ff_lower(t,i,kforestry) = vm_prod_future_reg_ff.lo(i,kforestry);
p21_prod_future_reg_ff_upper(t,i,kforestry) = vm_prod_future_reg_ff.up(i,kforestry);

vm_prod_future_reg_ff.l(i,kforestry) = i21_demand_forestry_future(i,kforestry)$(vm_prod_future_reg_ff.l(i,kforestry) < i21_demand_forestry_future(i,kforestry));

p21_prod_future_reg_ff_level(i,kforestry) = vm_prod_future_reg_ff.l(i,kforestry);

$ontext
pm_prod_future_reg_ff_lower(t,i,kforestry) = (i21_demand_forestry_future(i,kforestry) + i21_excess_prod_ff(i,kforestry)) * i21_trade_bal_reduction_future(kforestry)$(i21_selfsuff_forestry_future(i,kforestry) >= 1) + i21_demand_forestry_future(i,kforestry) * i21_selfsuff_forestry_future(i,kforestry) * i21_trade_bal_reduction_future(kforestry)$(i21_selfsuff_forestry_future(i,kforestry) < 1);

pm_prod_future_reg_ff_upper(t,i,kforestry) = ((i21_demand_forestry_future(i,kforestry) + i21_excess_prod_ff(i,kforestry))/ i21_trade_bal_reduction_future(kforestry))$(i21_selfsuff_forestry_future(i,kforestry) >= 1) + (i21_demand_forestry_future(i,kforestry)*i21_selfsuff_forestry_future(i,kforestry)/i21_trade_bal_reduction_future(kforestry))$(i21_selfsuff_forestry_future(i,kforestry) < 1);

pm_prod_future_reg_ff_level(i,kforestry) = i21_demand_forestry_future(i,kforestry)$(pm_prod_future_reg_ff_upper(t,i,kforestry) < i21_demand_forestry_future(i,kforestry));
$offtext
*vm_cost_trade_forestry_ff.fx(i) = sum(kforestry,(i21_trade_margin_ff(i,kforestry) + i21_trade_tariff_ff(i,kforestry))*(vm_prod_future_reg_ff.l(i,kforestry)-i21_demand_forestry_future(i,kforestry)));
