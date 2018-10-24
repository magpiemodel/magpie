*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*' @code
*' The fbask_jan16 realization of the livestock module also estimates an exogenous 
*' pasture management factor `pm_past_mngmnt_factor` that is used to scale
*' biophysical pasture yields in the module [14_yields].

*' The exogenous calculation of pasture management requires information on
*' the number of cattle reared to fulfil the domestic demand for ruminant 
*' livestock products: 

p70_cattle_stock_proxy(t,i) = im_pop(t,i)*pm_kcal_pc_initial(t,i,"livst_rum")
		              /i70_livestock_productivity(t,i,"sys_beef");   

*' The lower bound for `p70_cattle_stock_proxy` is set to 20% of initial cattle 
*' stocks in 1995:

p70_cattle_stock_proxy(t,i)$(p70_cattle_stock_proxy(t,i) < 0.2*p70_cattle_stock_proxy("y1995",i)) = 0.2*p70_cattle_stock_proxy("y1995",i);

*' The parameter `p70_incr_cattle` describes the changes in cattle stocks 
*' relative to the previous time step:

p70_incr_cattle(t,i)  =  1$(ord(t)=1)
			+ (p70_cattle_stock_proxy(t,i)/p70_cattle_stock_proxy(t-1,i))$(ord(t)>1);

*' The pasture management factor is calculated by applying a linear relationship 
*' that links changes in pasture management with changes in cattle stocks:

if (sum(sameas(t_past,t),1) = 1,
   pm_past_mngmnt_factor(t,i) = 1;
else               
   pm_past_mngmnt_factor(t,i) =   ( (s70_pyld_intercept + f70_pyld_slope_reg(i)*p70_incr_cattle(t,i)**(5/(m_year(t)-m_year(t-1))) 
	         )**((m_year(t)-m_year(t-1))/5) )*pm_past_mngmnt_factor(t-1,i);
 );

*' @stop




