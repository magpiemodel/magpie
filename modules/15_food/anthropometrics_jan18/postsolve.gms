*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* For calculation of waste trajectories for exogenous diets:
if ((sameas(t,"y2010")),
    p15_demand2intake_ratio_ref(i) = p15_demand2intake_ratio(t,i);
);

*' The calibration parameter is added to the regression value.

   o15_bmi_shr(t,iso,sex,age,bmi_group15) =
           p15_bmi_shr_regr(t,iso,sex,age,bmi_group15)+
           i15_bmi_shr_calib(t,iso,sex,age,bmi_group15);

*' The BMI shares are not allowed to exceed the bounds 0 and 1. Values are corrected to the bounds.
   o15_bmi_shr(t,iso,sex,age,bmi_group15)$(o15_bmi_shr(t,iso,sex,age,bmi_group15)<=0) = 0.000001;
   o15_bmi_shr(t,iso,sex,age,bmi_group15)$(o15_bmi_shr(t,iso,sex,age,bmi_group15)>1) = 1;
*' In case that the bmi groups, due to calibration, exceed 1, we rescale to 1.
   o15_bmi_shr(t,iso,sex,age,bmi_group15)$(sum(bmi_group15_2, o15_bmi_shr(t,iso,sex,age,bmi_group15_2))>1) =
      o15_bmi_shr(t,iso,sex,age,bmi_group15)/sum(bmi_group15_2, o15_bmi_shr(t,iso,sex,age,bmi_group15_2));
*' The mismatch below one is balanced by moving the exceeding quantities into the middle BMI group.
   o15_bmi_shr(t,iso,sex,age,"medium")=
      1 - (sum(bmi_group15, o15_bmi_shr(t,iso,sex,age,bmi_group15)) - o15_bmi_shr(t,iso,sex,age,"medium"));


*' We recalculate the intake with the new values.
   o15_kcal_intake_total(t,iso) =
         (
           sum((sex, age, bmi_group15),
               o15_bmi_shr(t,iso,sex,age,bmi_group15)*
               im_demography(t,iso,sex,age) *
               p15_intake(t,iso,sex,age,bmi_group15)
           ) + i15_kcal_pregnancy(t,iso)
         )/sum((sex,age), im_demography(t,iso,sex,age));



if(ord(t)>1,
* start from bodyheight structure of last period
   p15_bodyheight(t,iso,sex,age,"final") = p15_bodyheight(t-1,iso,sex,age,"final");
   p15_kcal_growth_food(t,iso,underaged15) = p15_kcal_growth_food(t-1,iso,underaged15);
);

s15_yeardiff = m_yeardiff(t)/5;
if(s15_yeardiff<1,s15_yeardiff=1);

For (s15_count = 1 to s15_yeardiff,

* circular move of age by 5 years
* to find out about ++1 search for help on Circular Lag and Lead Operators in Assignments
   p15_bodyheight(t,iso,sex,age++1,"final") = p15_bodyheight(t,iso,sex,age,"final");

* move on consumption agegroups by 5 years
   p15_kcal_growth_food(t,iso,underaged15++1)=
            p15_kcal_growth_food(t,iso,underaged15);

* consumption is calculated as linear interpolation between timesteps
   p15_kcal_growth_food(t,iso,"0--4") =
            sum(growth_food15,
                p15_kcal_pc_iso(t,iso,growth_food15) * (s15_count / (m_yeardiff(t)/5))
                + p15_kcal_pc_iso(t-1,iso,growth_food15) * (1 - s15_count / (m_yeardiff(t)/5))
            );

*' @code
*' After each execution of the food demand model, the body height distribution
*' of the population is estimated. The starting point is the body height
*' distribution of the last timestep. The body height estimates of the old
*' period are moved into the subsequent age class (e.g. the 20-24 year old are
*' now 25-29 years old). The age class of 15-19 year old is estimated newly
*' using the body height regressions and the food consumption of the last 15
*' years.

   p15_bodyheight(t,iso,sex,"15--19","final") =
                     f15_bodyheight_regr_paras(sex,"slope")*
                     (sum(underaged15,
                       p15_kcal_growth_food(t,iso,underaged15)
                     )/3)**f15_bodyheight_regr_paras(sex,"exponent")
                     ;

*' @stop
);

*' @code
*' The bodyheight of the underaged age class (0-14) is assumed to diverge from 'normal'
*' body height by the same proportion as the age class of the 15-19 year old.

p15_bodyheight(t,iso,"M","0--4","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*92;
p15_bodyheight(t,iso,"M","5--9","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*125;
p15_bodyheight(t,iso,"M","10--14","final")=p15_bodyheight(t,iso,"M","15--19","final")/176*152;

p15_bodyheight(t,iso,"F","0--4","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*91;
p15_bodyheight(t,iso,"F","5--9","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*124;
p15_bodyheight(t,iso,"F","10--14","final")=p15_bodyheight(t,iso,"M","15--19","final")/163*154;

*' @stop

*' @code
*' Finally, the regression outcome is calibrated by a country-specific additive
*' term, which is the residual of the regression fit and observation of the last
*' historical time step.

if (sum(sameas(t_past,t),1) = 1,
* For historical period, the regression results are only used to estimate the calibration parameter.
  p15_bodyheight_calib(t,iso,sex,age_new_estimated15) = f15_bodyheight(t,iso,sex,age_new_estimated15) - p15_bodyheight(t,iso,sex,age_new_estimated15,"final");
  p15_bodyheight(t,iso,sex,age_new_estimated15,"final") = f15_bodyheight(t,iso,sex,age_new_estimated15);
else
  p15_bodyheight_calib(t,iso,sex,age_new_estimated15)=p15_bodyheight_calib(t-1,iso,sex,age_new_estimated15);
  p15_bodyheight(t,iso,sex,age_new_estimated15,"final")=p15_bodyheight(t,iso,sex,age_new_estimated15,"final")+p15_bodyheight_calib(t,iso,sex,age_new_estimated15)*s15_calibrate;
);

*' @stop




*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_dem_food(t,i,kall,"marginal")                                     = vm_dem_food.m(i,kall);
 ov15_kcal_regr(t,iso,kfo,"marginal")                                 = v15_kcal_regr.m(iso,kfo);
 ov15_kcal_regr_total(t,iso,"marginal")                               = v15_kcal_regr_total.m(iso);
 ov15_demand_regr(t,iso,regr15,"marginal")                            = v15_demand_regr.m(iso,regr15);
 ov15_income_pc_real_ppp_iso(t,iso,"marginal")                        = v15_income_pc_real_ppp_iso.m(iso);
 ov15_income_balance(t,iso,"marginal")                                = v15_income_balance.m(iso);
 ov15_kcal_intake_total_regr(t,iso,"marginal")                        = v15_kcal_intake_total_regr.m(iso);
 ov15_regr_overgroups(t,iso,sex,agegroup15,bmi_tree15,"marginal")     = v15_regr_overgroups.m(iso,sex,agegroup15,bmi_tree15);
 ov15_bmi_shr_regr(t,iso,sex,age,bmi_group15,"marginal")              = v15_bmi_shr_regr.m(iso,sex,age,bmi_group15);
 ov15_bmi_shr_overgroups(t,iso,sex,agegroup15,bmi_group15,"marginal") = v15_bmi_shr_overgroups.m(iso,sex,agegroup15,bmi_group15);
 ov15_objective(t,"marginal")                                         = v15_objective.m;
 oq15_food_demand(t,i,kfo,"marginal")                                 = q15_food_demand.m(i,kfo);
 oq15_aim(t,"marginal")                                               = q15_aim.m;
 oq15_budget(t,iso,"marginal")                                        = q15_budget.m(iso);
 oq15_regr_bmi_shr(t,iso,sex,agegroup15,bmi_tree15,"marginal")        = q15_regr_bmi_shr.m(iso,sex,agegroup15,bmi_tree15);
 oq15_bmi_shr_verylow(t,iso,sex,agegroup15,"marginal")                = q15_bmi_shr_verylow.m(iso,sex,agegroup15);
 oq15_bmi_shr_low(t,iso,sex,agegroup15,"marginal")                    = q15_bmi_shr_low.m(iso,sex,agegroup15);
 oq15_bmi_shr_medium(t,iso,sex,agegroup15,"marginal")                 = q15_bmi_shr_medium.m(iso,sex,agegroup15);
 oq15_bmi_shr_medium_high(t,iso,sex,agegroup15,"marginal")            = q15_bmi_shr_medium_high.m(iso,sex,agegroup15);
 oq15_bmi_shr_high(t,iso,sex,agegroup15,"marginal")                   = q15_bmi_shr_high.m(iso,sex,agegroup15);
 oq15_bmi_shr_veryhigh(t,iso,sex,agegroup15,"marginal")               = q15_bmi_shr_veryhigh.m(iso,sex,agegroup15);
 oq15_bmi_shr_agg(t,iso,sex,age,bmi_group15,"marginal")               = q15_bmi_shr_agg.m(iso,sex,age,bmi_group15);
 oq15_intake(t,iso,"marginal")                                        = q15_intake.m(iso);
 oq15_regr_kcal(t,iso,"marginal")                                     = q15_regr_kcal.m(iso);
 oq15_regr(t,iso,regr15,"marginal")                                   = q15_regr.m(iso,regr15);
 oq15_foodtree_kcal_animals(t,iso,kfo_ap,"marginal")                  = q15_foodtree_kcal_animals.m(iso,kfo_ap);
 oq15_foodtree_kcal_processed(t,iso,kfo_pf,"marginal")                = q15_foodtree_kcal_processed.m(iso,kfo_pf);
 oq15_foodtree_kcal_staples(t,iso,kfo_st,"marginal")                  = q15_foodtree_kcal_staples.m(iso,kfo_st);
 oq15_foodtree_kcal_vegetables(t,iso,"marginal")                      = q15_foodtree_kcal_vegetables.m(iso);
 ov_dem_food(t,i,kall,"level")                                        = vm_dem_food.l(i,kall);
 ov15_kcal_regr(t,iso,kfo,"level")                                    = v15_kcal_regr.l(iso,kfo);
 ov15_kcal_regr_total(t,iso,"level")                                  = v15_kcal_regr_total.l(iso);
 ov15_demand_regr(t,iso,regr15,"level")                               = v15_demand_regr.l(iso,regr15);
 ov15_income_pc_real_ppp_iso(t,iso,"level")                           = v15_income_pc_real_ppp_iso.l(iso);
 ov15_income_balance(t,iso,"level")                                   = v15_income_balance.l(iso);
 ov15_kcal_intake_total_regr(t,iso,"level")                           = v15_kcal_intake_total_regr.l(iso);
 ov15_regr_overgroups(t,iso,sex,agegroup15,bmi_tree15,"level")        = v15_regr_overgroups.l(iso,sex,agegroup15,bmi_tree15);
 ov15_bmi_shr_regr(t,iso,sex,age,bmi_group15,"level")                 = v15_bmi_shr_regr.l(iso,sex,age,bmi_group15);
 ov15_bmi_shr_overgroups(t,iso,sex,agegroup15,bmi_group15,"level")    = v15_bmi_shr_overgroups.l(iso,sex,agegroup15,bmi_group15);
 ov15_objective(t,"level")                                            = v15_objective.l;
 oq15_food_demand(t,i,kfo,"level")                                    = q15_food_demand.l(i,kfo);
 oq15_aim(t,"level")                                                  = q15_aim.l;
 oq15_budget(t,iso,"level")                                           = q15_budget.l(iso);
 oq15_regr_bmi_shr(t,iso,sex,agegroup15,bmi_tree15,"level")           = q15_regr_bmi_shr.l(iso,sex,agegroup15,bmi_tree15);
 oq15_bmi_shr_verylow(t,iso,sex,agegroup15,"level")                   = q15_bmi_shr_verylow.l(iso,sex,agegroup15);
 oq15_bmi_shr_low(t,iso,sex,agegroup15,"level")                       = q15_bmi_shr_low.l(iso,sex,agegroup15);
 oq15_bmi_shr_medium(t,iso,sex,agegroup15,"level")                    = q15_bmi_shr_medium.l(iso,sex,agegroup15);
 oq15_bmi_shr_medium_high(t,iso,sex,agegroup15,"level")               = q15_bmi_shr_medium_high.l(iso,sex,agegroup15);
 oq15_bmi_shr_high(t,iso,sex,agegroup15,"level")                      = q15_bmi_shr_high.l(iso,sex,agegroup15);
 oq15_bmi_shr_veryhigh(t,iso,sex,agegroup15,"level")                  = q15_bmi_shr_veryhigh.l(iso,sex,agegroup15);
 oq15_bmi_shr_agg(t,iso,sex,age,bmi_group15,"level")                  = q15_bmi_shr_agg.l(iso,sex,age,bmi_group15);
 oq15_intake(t,iso,"level")                                           = q15_intake.l(iso);
 oq15_regr_kcal(t,iso,"level")                                        = q15_regr_kcal.l(iso);
 oq15_regr(t,iso,regr15,"level")                                      = q15_regr.l(iso,regr15);
 oq15_foodtree_kcal_animals(t,iso,kfo_ap,"level")                     = q15_foodtree_kcal_animals.l(iso,kfo_ap);
 oq15_foodtree_kcal_processed(t,iso,kfo_pf,"level")                   = q15_foodtree_kcal_processed.l(iso,kfo_pf);
 oq15_foodtree_kcal_staples(t,iso,kfo_st,"level")                     = q15_foodtree_kcal_staples.l(iso,kfo_st);
 oq15_foodtree_kcal_vegetables(t,iso,"level")                         = q15_foodtree_kcal_vegetables.l(iso);
 ov_dem_food(t,i,kall,"upper")                                        = vm_dem_food.up(i,kall);
 ov15_kcal_regr(t,iso,kfo,"upper")                                    = v15_kcal_regr.up(iso,kfo);
 ov15_kcal_regr_total(t,iso,"upper")                                  = v15_kcal_regr_total.up(iso);
 ov15_demand_regr(t,iso,regr15,"upper")                               = v15_demand_regr.up(iso,regr15);
 ov15_income_pc_real_ppp_iso(t,iso,"upper")                           = v15_income_pc_real_ppp_iso.up(iso);
 ov15_income_balance(t,iso,"upper")                                   = v15_income_balance.up(iso);
 ov15_kcal_intake_total_regr(t,iso,"upper")                           = v15_kcal_intake_total_regr.up(iso);
 ov15_regr_overgroups(t,iso,sex,agegroup15,bmi_tree15,"upper")        = v15_regr_overgroups.up(iso,sex,agegroup15,bmi_tree15);
 ov15_bmi_shr_regr(t,iso,sex,age,bmi_group15,"upper")                 = v15_bmi_shr_regr.up(iso,sex,age,bmi_group15);
 ov15_bmi_shr_overgroups(t,iso,sex,agegroup15,bmi_group15,"upper")    = v15_bmi_shr_overgroups.up(iso,sex,agegroup15,bmi_group15);
 ov15_objective(t,"upper")                                            = v15_objective.up;
 oq15_food_demand(t,i,kfo,"upper")                                    = q15_food_demand.up(i,kfo);
 oq15_aim(t,"upper")                                                  = q15_aim.up;
 oq15_budget(t,iso,"upper")                                           = q15_budget.up(iso);
 oq15_regr_bmi_shr(t,iso,sex,agegroup15,bmi_tree15,"upper")           = q15_regr_bmi_shr.up(iso,sex,agegroup15,bmi_tree15);
 oq15_bmi_shr_verylow(t,iso,sex,agegroup15,"upper")                   = q15_bmi_shr_verylow.up(iso,sex,agegroup15);
 oq15_bmi_shr_low(t,iso,sex,agegroup15,"upper")                       = q15_bmi_shr_low.up(iso,sex,agegroup15);
 oq15_bmi_shr_medium(t,iso,sex,agegroup15,"upper")                    = q15_bmi_shr_medium.up(iso,sex,agegroup15);
 oq15_bmi_shr_medium_high(t,iso,sex,agegroup15,"upper")               = q15_bmi_shr_medium_high.up(iso,sex,agegroup15);
 oq15_bmi_shr_high(t,iso,sex,agegroup15,"upper")                      = q15_bmi_shr_high.up(iso,sex,agegroup15);
 oq15_bmi_shr_veryhigh(t,iso,sex,agegroup15,"upper")                  = q15_bmi_shr_veryhigh.up(iso,sex,agegroup15);
 oq15_bmi_shr_agg(t,iso,sex,age,bmi_group15,"upper")                  = q15_bmi_shr_agg.up(iso,sex,age,bmi_group15);
 oq15_intake(t,iso,"upper")                                           = q15_intake.up(iso);
 oq15_regr_kcal(t,iso,"upper")                                        = q15_regr_kcal.up(iso);
 oq15_regr(t,iso,regr15,"upper")                                      = q15_regr.up(iso,regr15);
 oq15_foodtree_kcal_animals(t,iso,kfo_ap,"upper")                     = q15_foodtree_kcal_animals.up(iso,kfo_ap);
 oq15_foodtree_kcal_processed(t,iso,kfo_pf,"upper")                   = q15_foodtree_kcal_processed.up(iso,kfo_pf);
 oq15_foodtree_kcal_staples(t,iso,kfo_st,"upper")                     = q15_foodtree_kcal_staples.up(iso,kfo_st);
 oq15_foodtree_kcal_vegetables(t,iso,"upper")                         = q15_foodtree_kcal_vegetables.up(iso);
 ov_dem_food(t,i,kall,"lower")                                        = vm_dem_food.lo(i,kall);
 ov15_kcal_regr(t,iso,kfo,"lower")                                    = v15_kcal_regr.lo(iso,kfo);
 ov15_kcal_regr_total(t,iso,"lower")                                  = v15_kcal_regr_total.lo(iso);
 ov15_demand_regr(t,iso,regr15,"lower")                               = v15_demand_regr.lo(iso,regr15);
 ov15_income_pc_real_ppp_iso(t,iso,"lower")                           = v15_income_pc_real_ppp_iso.lo(iso);
 ov15_income_balance(t,iso,"lower")                                   = v15_income_balance.lo(iso);
 ov15_kcal_intake_total_regr(t,iso,"lower")                           = v15_kcal_intake_total_regr.lo(iso);
 ov15_regr_overgroups(t,iso,sex,agegroup15,bmi_tree15,"lower")        = v15_regr_overgroups.lo(iso,sex,agegroup15,bmi_tree15);
 ov15_bmi_shr_regr(t,iso,sex,age,bmi_group15,"lower")                 = v15_bmi_shr_regr.lo(iso,sex,age,bmi_group15);
 ov15_bmi_shr_overgroups(t,iso,sex,agegroup15,bmi_group15,"lower")    = v15_bmi_shr_overgroups.lo(iso,sex,agegroup15,bmi_group15);
 ov15_objective(t,"lower")                                            = v15_objective.lo;
 oq15_food_demand(t,i,kfo,"lower")                                    = q15_food_demand.lo(i,kfo);
 oq15_aim(t,"lower")                                                  = q15_aim.lo;
 oq15_budget(t,iso,"lower")                                           = q15_budget.lo(iso);
 oq15_regr_bmi_shr(t,iso,sex,agegroup15,bmi_tree15,"lower")           = q15_regr_bmi_shr.lo(iso,sex,agegroup15,bmi_tree15);
 oq15_bmi_shr_verylow(t,iso,sex,agegroup15,"lower")                   = q15_bmi_shr_verylow.lo(iso,sex,agegroup15);
 oq15_bmi_shr_low(t,iso,sex,agegroup15,"lower")                       = q15_bmi_shr_low.lo(iso,sex,agegroup15);
 oq15_bmi_shr_medium(t,iso,sex,agegroup15,"lower")                    = q15_bmi_shr_medium.lo(iso,sex,agegroup15);
 oq15_bmi_shr_medium_high(t,iso,sex,agegroup15,"lower")               = q15_bmi_shr_medium_high.lo(iso,sex,agegroup15);
 oq15_bmi_shr_high(t,iso,sex,agegroup15,"lower")                      = q15_bmi_shr_high.lo(iso,sex,agegroup15);
 oq15_bmi_shr_veryhigh(t,iso,sex,agegroup15,"lower")                  = q15_bmi_shr_veryhigh.lo(iso,sex,agegroup15);
 oq15_bmi_shr_agg(t,iso,sex,age,bmi_group15,"lower")                  = q15_bmi_shr_agg.lo(iso,sex,age,bmi_group15);
 oq15_intake(t,iso,"lower")                                           = q15_intake.lo(iso);
 oq15_regr_kcal(t,iso,"lower")                                        = q15_regr_kcal.lo(iso);
 oq15_regr(t,iso,regr15,"lower")                                      = q15_regr.lo(iso,regr15);
 oq15_foodtree_kcal_animals(t,iso,kfo_ap,"lower")                     = q15_foodtree_kcal_animals.lo(iso,kfo_ap);
 oq15_foodtree_kcal_processed(t,iso,kfo_pf,"lower")                   = q15_foodtree_kcal_processed.lo(iso,kfo_pf);
 oq15_foodtree_kcal_staples(t,iso,kfo_st,"lower")                     = q15_foodtree_kcal_staples.lo(iso,kfo_st);
 oq15_foodtree_kcal_vegetables(t,iso,"lower")                         = q15_foodtree_kcal_vegetables.lo(iso);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
