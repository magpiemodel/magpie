*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*------------------
****** Costs ******
*------------------

*' The direct costs of Timber production and afforestation `vm_cost_fore` include
*' maintenance and monitoring costs for newly established plantations as well as
*' standing plantations '[@sathaye_ghg_2005]. In addition, this type of forest management
*' (including afforestation) may cause costs in other parts of the model such as costs
*' for technological change [13_tc] or land expansion [39_landconversion]. Also included
*' are additional costs for producing timber from extremely highly managed plantations
*' which are analogous to intensification using technological change from [13_tc] but
*' in a parametrized form.

q32_cost_total(i2) .. vm_cost_fore(i2) =e=
                   v32_cost_recur(i2)
                   + v32_cost_establishment(i2)
                   + v32_cost_hvarea(i2)
                   + sum(cell(i2,j2), v32_land_missing(j2)) * s32_free_land_cost
                   ;

*-----------------------------------------------
****** Carbon price induced afforestation ******
*-----------------------------------------------
*' The interface `vm_cdr_aff` provides the projected biogeochemical (bgc) carbon sequestration
*' and the local biophysical (bph) warming/cooling effects of an afforestation
*' activity for a planning horizon of 50 years `s32_planing_horizon` to the [56_ghg_policy] module.

q32_cdr_aff(j2,ac) ..
vm_cdr_aff(j2,ac,"bgc") =e=
sum(ac_est, v32_land(j2,"aff",ac_est)) * sum(ct, p32_cdr_ac(ct,j2,ac))
;

q32_bgp_aff(j2,ac) ..
vm_cdr_aff(j2,ac,"bph") =e=
sum(ac_est, v32_land(j2,"aff",ac_est)) * p32_aff_bgp(j2,ac);

*' ac_est can only increase if total afforested land increases
q32_aff_est(j2) ..
sum(ac_est, v32_land(j2,"aff",ac_est)) =l= sum(ac, v32_land(j2,"aff",ac)) - sum((ct,ac), p32_land(ct,j2,"aff",ac));

*-----------------------------------------------
****************** Land ************************
*-----------------------------------------------

*' The interface `vm_land` provides aggregated forestry land pools (`type32`) to other modules.

 q32_land(j2) ..
 vm_land(j2,"forestry") =e= sum((type32,ac), v32_land(j2,type32,ac));

 q32_land_type32(j2,type32) ..
 vm_land_forestry(j2,type32) =e= sum(ac, v32_land(j2,type32,ac));

 q32_land_expansion_forestry(j2,type32) ..
 vm_landexpansion_forestry(j2,type32) =e= v32_land_expansion(j2,type32);

 q32_land_reduction_forestry(j2,type32) ..
 vm_landreduction_forestry(j2,type32) =e= sum(ac_sub, v32_land_reduction(j2,type32,ac_sub));

*' The constraint `q32_aff_pol` accounts for the exogenous afforestation prescribed by NPI/NDC policies.

 q32_aff_pol(j2) ..
 sum(ac_est, v32_land(j2,"ndc",ac_est)) =e= sum(ct, p32_aff_pol_timestep(ct,j2));

*' The constraint `q32_max_aff` accounts for the allowed maximum global endogenous 
*' afforestation defined in `i32_max_aff_area_glo`. 
*' The constraint `q32_max_aff_reg` accounts for the allowed maximum regional endogenous 
*' afforestation defined in `i32_max_aff_area_reg`. 
*' Only one of the two constraints is active, depending on `s32_max_aff_area_glo`.

 q32_max_aff$(s32_max_aff_area_glo=1) .. 
  sum((j2,ac), v32_land(j2,"aff",ac))
      =l= sum(ct, i32_max_aff_area_glo(ct));

 q32_max_aff_reg(i2)$(s32_max_aff_area_glo=0) .. 
  sum((cell(i2,j2),ac), v32_land(j2,"aff",ac))
        =l= sum(ct, i32_max_aff_area_reg(ct,i2));

*-----------------------------------------------
************** Carbon stock ********************
*-----------------------------------------------
*' Forestry above ground carbon stocks are calculated as the product of forestry land (`v32_land`) and the area
*' weighted mean of carbon density for carbon pools (`p32_carbon_density_ac`).

 q32_carbon(j2,ag_pools,stockType) .. vm_carbon_stock(j2,"forestry",ag_pools,stockType) =e=
            m_carbon_stock_ac(v32_land,p32_carbon_density_ac,"type32,ac","type32,ac_sub");

*' Forestry land expansion and reduction is calculated as follows:

 q32_land_diff .. vm_landdiff_forestry =e= sum((j2,type32),
            v32_land_expansion(j2,type32)
          + sum(ac_sub, v32_land_reduction(j2,type32,ac_sub)));

 q32_land_expansion(j2,type32) ..
    v32_land_expansion(j2,type32) =e= 
    sum(ac_est, v32_land(j2,type32,ac_est));

 q32_land_reduction(j2,type32,ac_sub) ..
  v32_land_reduction(j2,type32,ac_sub) =e= pc32_land(j2,type32,ac_sub) - v32_land(j2,type32,ac_sub);

*------------------------------------------
*********** Biodiversity value ************
*------------------------------------------

q32_bv_aff(j2,potnatveg) .. vm_bv(j2,"aff_co2p",potnatveg)
          =e=
          sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v32_land(j2,"aff",ac)) * 
          p32_bii_coeff("aff",bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);

q32_bv_ndc(j2,potnatveg) .. vm_bv(j2,"aff_ndc",potnatveg)
          =e=
          sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v32_land(j2,"ndc",ac)) * 
          p32_bii_coeff("ndc",bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);

q32_bv_plant(j2,potnatveg) .. vm_bv(j2,"plant",potnatveg)
          =e=
          sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v32_land(j2,"plant",ac)) * 
          p32_bii_coeff("plant",bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);


************************************************************
**** Timber production related equations in plantations ****
************************************************************

**** Cost calculations
*---------------------

*' Cost of new plantations establishment `v32_cost_establishment` is the investment
*' made in setting up new plantations but also accounts for the expected value of
*' future harvesting costs. This makes sure that the model sticks to reasonable plantation
*' patterns over time. Present value of harvesting costs is (1+`pm_interest`)^`p32_rotation_regional`
*' and annuity factor of `pm_interest`/(1+`pm_interest`) averages the cost of this
*' investment over time.

q32_cost_establishment(i2)..
            v32_cost_establishment(i2)
            =e=
            (sum((cell(i2,j2),type32,ac_est), v32_land(j2,type32,ac_est) * s32_reESTBcost)
              )
            * sum(ct,pm_interest(ct,i2)/(1+pm_interest(ct,i2)));


*' Recurring costs are paid for plantations where the trees have to be regularly monitored
*' and maintained. These costs are only calculated becuase we see active human intervention
*' in commercial plantations. These costs are paid for trees used for timber production or
*' trees established for afforestation purposes.

q32_cost_recur(i2) .. v32_cost_recur(i2) =e=
                    sum((cell(i2,j2),type32,ac_sub), v32_land(j2,type32,ac_sub)) * s32_recurring_cost;


**** New establishment decision
*------------------------------
*' New plantations are already established in the optimization step based on a certain
*' percentage (`p32_plantation_contribution`) of current demand (`pm_demand_forestry_future`).
*' Its called `pm_demand_forestry_future` because the model also has a foresight switch which
*' give the model an ability to account for future changes in demand. By default `pm_demand_forestry_future`
*' is set to existing roundwood demand. As plantation establishment decisions should
*' also know some indication of expected future yields, we calculate how much yield
*' newly established plantation can realize based on rotation lengths. This is defined as
*' the expected future yield (`pc32_yield_forestry_future`) at harvest (year in time
*' step are accounted for).

*' Area constraint for plantation establishment based on expected average regional timber yield at rotation age
*' (`pc32_yield_forestry_future_reg`) to ovoid overspecialization of plantation establishment towards highly productive cells.

q32_establishment_dynamic(i2)$s32_establishment_dynamic ..
              sum(cell(i2,j2), ((sum(ac_est, v32_land(j2,"plant",ac_est)) + v32_land_missing(j2)) / m_timestep_length_forestry) * pc32_yield_forestry_future_reg(i2))
              =e=
              sum((ct,kforestry), pm_demand_forestry_future(i2,kforestry) *  min(s32_max_self_suff, sum(supreg(h2,i2),pm_selfsuff_ext(ct,h2,kforestry))) * p32_plantation_contribution(ct,i2) * f32_estb_calib(i2))
              ;

*' Constraint to maintain the average regional timber yield at rotation age, accounting for the cellular timber yield (`pc32_yield_forestry_future`).

q32_establishment_dynamic_yield(i2)$s32_establishment_dynamic ..
      sum(cell(i2,j2), (sum(ac_est, v32_land(j2,"plant",ac_est))+v32_land_missing(j2)) * pc32_yield_forestry_future(j2))
      =e=
      pc32_yield_forestry_future_reg(i2) * (sum(cell(i2,j2), sum(ac_est, v32_land(j2,"plant",ac_est))+v32_land_missing(j2)));

*' If plantations have to be static (defined by `s32_establishment_static`) then
*' the model simply establishes the amount of plantations which are harvested.
*' this keeps the plantation area static but accounts for age-class changes and
*' regrowth during every time step.

q32_establishment_fixed(j2)$s32_establishment_static ..
  sum(ac, v32_land(j2,"plant",ac)) =e= sum(ac, pc32_land(j2,"plant",ac));


*' This constraint distributes additions to forestry land over ac_est,
*' which depends on the time step length (e.g. ac0 and ac5 for a 10 year time step).

q32_forestry_est(j2,type32,ac_est) ..
v32_land(j2,type32,ac_est) =e= sum(ac_est2, v32_land(j2,type32,ac_est2))/card(ac_est2);

*' Change in forestry area is the difference between plantation area from previous time
*' step ('pc32_land') and optimized plantation area from current time step ('v32_land')

q32_hvarea_forestry(j2,ac_sub) ..
                          v32_hvarea_forestry(j2,ac_sub)
                          =l=
                          v32_land_reduction(j2,"plant",ac_sub);

** Timber plantation
*' Woody biomass production from timber plantations is calculated by multiplying the
*' area under production with corresponding yields of plantation forests, divided by the timestep length.

q32_prod_forestry(j2)..
                         sum(kforestry, vm_prod_forestry(j2,kforestry))
                         =e=
                         sum(ac_sub, v32_hvarea_forestry(j2,ac_sub) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"forestry"))) / m_timestep_length_forestry;

*' Harvesting cost in plantations is defined as the cost incurred while removing
*' biomass from such forests.

q32_cost_hvarea(i2)..
                    v32_cost_hvarea(i2)
                    =e=
                    sum((ct,cell(i2,j2),ac_sub), v32_hvarea_forestry(j2,ac_sub))   * s32_harvesting_cost
                    ;

*** EOF equations.gms ***
