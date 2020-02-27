** Weighting future rotation calculation for mean regional values by area
pm_rotation_reg(t,i) = ord(t) + ceil((sum(cell(i,j),pcm_land(j,"forestry")*pm_rot_length_estb(t,j))/sum(cell(i,j),pcm_land(j,"forestry")))/5) + card(t_past_ff);

** Checking future numbers
pc21_demand_forestry_future(i,kforestry)    = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),pm_demand_ext(t_ext,i,kforestry));
pc21_selfsuff_forestry_future(i,kforestry)  = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),p21_selfsuff_ext(t_ext,i,kforestry));
pc21_trade_bal_reduction_future(kforestry)  = sum(t_ext, i21_trade_bal_reduction_ff(t_ext,kforestry))/card(t_ext);
pc21_trade_balanceflow_future(kforestry)    = sum(t_ext, p21_trade_balanceflow_ext(t_ext,kforestry))/card(t_ext);
pc21_exp_shr_future(i,kforestry)            = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),p21_exp_shr_ext(t_ext,i,kforestry));
pcm_production_ratio_future(i)               = sum(t_ext$(t_ext.pos = pm_rotation_reg(t,i)),pm_production_ratio_ext(t_ext,i));
