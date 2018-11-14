vm_prod_future_reg_ff.fx(i,kforestry2)    = 0 ;
v21_excess_prod_ff.fx(i,kforestry2)       = 0 ;
v21_excess_dem_ff.fx(kforestry2)          = 0 ;
v21_excess_prod_ff.fx(i,kforestry2)       = 0 ;
v21_cost_trade_reg_ff.fx(i,kforestry2)    = 0 ;
vm_cost_trade_forestry_ff.fx(i)           = 0 ;
pm_rotation_reg(i) = ord(t) + ceil(pm_rot_length(i)/5) + card(t_past_ff);
pcm_production_ratio_future(i)               = sum(t_ext$(t_ext.pos = pm_rotation_reg(i)),pm_production_ratio_ext(i,t_ext));
