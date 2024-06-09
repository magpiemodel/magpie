*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' The interface `vm_land` provides aggregated natveg land pools (`ac`) to other modules.

 q35_land_secdforest(j2) .. vm_land(j2,"secdforest") =e= sum(ac, v35_secdforest(j2,ac));

 q35_land_other(j2) .. vm_land(j2,"other") =e= sum((othertype35,ac), vm_land_other(j2,othertype35,ac));

*' The total natural land area cannot be smaller than the total natural land conservation target.
*' Area requirements for natural land conservation are derived from WDPA and formulated based on
*' conservation priority areas during future time steps.

 q35_natveg_conservation(j2) ..
            sum(land_natveg, vm_land(j2,land_natveg))
            =g=
            sum((ct,land_natveg), pm_land_conservation(ct,j2,land_natveg,"protect"));

 q35_secdforest_restoration(j2) ..
            sum(land_ag, vm_lu_transitions(j2,land_ag,"secdforest"))
          + vm_lu_transitions(j2,"forestry","secdforest")
            =g=
            p35_land_restoration(j2,"secdforest");

 q35_other_restoration(j2) ..
            sum(land_ag, vm_lu_transitions(j2,land_ag,"other"))
            =g=
            p35_land_restoration(j2,"other");

*' Carbon stocks for primary forest, secondary forest or other natural land are calculated
*' as the product of respective area and carbon density.
*' Carbon stocks decline if the area decreases
*' (e.g. due to cropland expansion into forests).
*' In case of abandoned agricultural land (increase of other natural land),
*' natural succession, represented by age-class growth, results in increasing carbon stocks.

 q35_carbon_primforest(j2,ag_pools,stockType) ..
    vm_carbon_stock(j2,"primforest",ag_pools,stockType) =e=
      m_carbon_stock(vm_land,fm_carbon_density,"primforest");

 q35_carbon_secdforest(j2,ag_pools,stockType) ..
    vm_carbon_stock(j2,"secdforest",ag_pools,stockType) =e=
      m_carbon_stock_ac(v35_secdforest,pm_carbon_density_secdforest_ac,"ac","ac_sub");

 q35_carbon_other(j2,ag_pools,stockType) ..
    vm_carbon_stock(j2,"other",ag_pools,stockType) =e=
      m_carbon_stock_ac(vm_land_other,p35_carbon_density_other,"othertype35,ac","othertype35,ac_sub");

*' The biodiversity value (BV) of primary forest, secondary forest and other land is computed by multiplying their respective land area with bii coefficients, which depend on the age class and whether the potential natural vegetation forest or non-forest (luh2 side layers).

 q35_bv_primforest(j2,potnatveg) .. vm_bv(j2,"primforest",potnatveg)
          =e=
          vm_land(j2,"primforest") * fm_bii_coeff("primary",potnatveg) * fm_luh2_side_layers(j2,potnatveg);

 q35_bv_secdforest(j2,potnatveg) .. vm_bv(j2,"secdforest",potnatveg)
          =e=
          sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), v35_secdforest(j2,ac)) *
          fm_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);

 q35_bv_other(j2,potnatveg) .. vm_bv(j2,"other",potnatveg)
          =e=
          sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), sum(othertype35, vm_land_other(j2,othertype35,ac))) *
          fm_bii_coeff(bii_class_secd,potnatveg)) * fm_luh2_side_layers(j2,potnatveg);

*' NPI/NDC land protection policies based on country reports are implemented as
*' minium forest and other land stocks. They are not interchangeable (as compared to
*' the natural land conservation constraint) and specifically formulated for forest and
*' other land stocks.

 q35_min_forest(j2) .. sum(land_forest, vm_land(j2,land_forest))
                       =g=
                       sum(ct, p35_min_forest(ct,j2));

 q35_min_other(j2) .. vm_land(j2,"other") =g= sum(ct, p35_min_other(ct,j2));

*' The following technical calculations are needed for reducing differences in land-use patterns between time steps.
*' The gross change in natural vegetation is calculated based on land expansion and
*' land contraction of other land, and land reduction of primary and secondary forest.
*' This information is then passed to the land module ([10_land]):

 q35_landdiff .. vm_landdiff_natveg =e=
          sum(j2,
              sum(othertype35,v35_other_expansion(j2,othertype35))
              + sum((othertype35,ac_sub), v35_other_reduction(j2,othertype35,ac_sub))
              + v35_secdforest_expansion(j2)
              + sum((ac_sub), v35_secdforest_reduction(j2,ac_sub))
              + v35_primforest_reduction(j2));

 q35_other_expansion(j2,othertype35) ..
  v35_other_expansion(j2,othertype35) =e=
    sum(ac_est, vm_land_other(j2,othertype35,ac_est));

 q35_other_reduction(j2,othertype35,ac_sub) ..
  v35_other_reduction(j2,othertype35,ac_sub) =e=
    pc35_land_other(j2,othertype35,ac_sub) - vm_land_other(j2,othertype35,ac_sub);

 q35_secdforest_expansion(j2) ..
  v35_secdforest_expansion(j2) =e=
    sum(ac_est, v35_secdforest(j2,ac_est));

 q35_secdforest_reduction(j2,ac_sub) ..
  v35_secdforest_reduction(j2,ac_sub) =e=
    pc35_secdforest(j2,ac_sub) - v35_secdforest(j2,ac_sub);

 q35_primforest_reduction(j2) ..
  v35_primforest_reduction(j2) =e=
    pcm_land(j2,"primforest") - vm_land(j2,"primforest");

*******************************************************************
**** Timber production related equations in natural vegetation ****
*******************************************************************

*' For natural forest, per-hectare harvesting costs are positive to make sure that older
*' forest with higher growing stock is preferred over younger forest.
*' To mimic the difficulties in accessing primary forest, per-hectare harvesting
*' costs for primary forest are higher than for secondary forest. Harvesting costs
*' are paid everytime natural vegetation is harvested. The "real" harvested area
*' are received from the timber module [73_timber].

q35_cost_hvarea(i2)..
                    vm_cost_hvarea_natveg(i2)
                    =e=
                   sum((ct,cell(i2,j2),ac_sub), v35_hvarea_secdforest(j2,ac_sub)) * s35_timber_harvest_cost_secdforest
                 + sum((ct,cell(i2,j2),othertype35,ac_sub), v35_hvarea_other(j2,othertype35,ac_sub)) * s35_timber_harvest_cost_other
                 + sum((ct,cell(i2,j2)), v35_hvarea_primforest(j2)) * s35_timber_harvest_cost_primforest
                    ;

** Secondary forest
*' Woody biomass production from secondary forests is calculated by multiplying the
*' area under production with corresponding yields of secondary forests, divided by the timestep length.

q35_prod_secdforest(j2)..
               sum(kforestry, vm_prod_natveg(j2,"secdforest",kforestry))
               =e=
               sum(ac_sub, v35_hvarea_secdforest(j2,ac_sub) * sum(ct,pm_timber_yield(ct,j2,ac_sub,"secdforest"))) / m_timestep_length_forestry;

** Primary forest
*' Woody biomass production from primary forests is calculated by multiplying the
*' area under production with corresponding yields of primary forests, divided by the timestep length.

q35_prod_primforest(j2)..
              sum(kforestry, vm_prod_natveg(j2,"primforest",kforestry))
              =e=
              v35_hvarea_primforest(j2) * sum(ct, pm_timber_yield(ct,j2,"acx","primforest")) / m_timestep_length_forestry;

** Other land
*' Wood-fuel production from other land is calculated by multiplying the area under
*' production with corresponding yields of other land, divided by the timestep length.
*' Wood production from other landis not allowed.

q35_prod_other(j2)..
               vm_prod_natveg(j2,"other","woodfuel")
               =e=
               (sum(ac_sub, v35_hvarea_other(j2,"othernat",ac_sub) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"other")))
              + sum(ac_sub, v35_hvarea_other(j2,"youngsecdf",ac_sub) * sum(ct, pm_timber_yield(ct,j2,ac_sub,"secdforest"))))
              / m_timestep_length_forestry
                ;

*' Following equations show the harvested area from natural vegetation i.e. primary
*' forests, secondary forests and other land. Important to note here that no wood
*' production should be realized from other land. Harvested area for production
*' purposes can be lower oe equal than land reduction in natural vegetation as
*' not all lost area is (or should be) used for production.

q35_hvarea_secdforest(j2,ac_sub)..
                v35_hvarea_secdforest(j2,ac_sub)
                =l=
                v35_secdforest_reduction(j2,ac_sub);

q35_hvarea_primforest(j2)..
                v35_hvarea_primforest(j2)
                =l=
                v35_primforest_reduction(j2);

q35_hvarea_other(j2,othertype35,ac_sub)..
                v35_hvarea_other(j2,othertype35,ac_sub)
                =l=
                v35_other_reduction(j2,othertype35,ac_sub);


*' The constraint for overall forest establishment, including forestry, is given
*' by the remaining potential forest area, which is derived from the potential
*' natural forestarea minus the recovering secondary forest area.

q35_max_forest_establishment(j2)..
                sum(land_forest, vm_landexpansion(j2,land_forest))
                =l=
                sum(ct,pm_max_forest_est(ct,j2))
              - sum(ac, vm_land_other(j2,"youngsecdf",ac) )
                ;

*' Harvested secondary forest is still considered secondary forests due to
*' restrictive NPI definitions. Also primary forest harvested will be considered
*' to be secondary forest i.e., harvested primary forest gets reclassified as
*' secondary forest and ends up in the youngest age-class (and follows regrowth)

q35_secdforest_regeneration(j2)..
                 sum(ac_est, v35_secdforest(j2,ac_est))
                 =e=
                 sum(ac_sub,v35_hvarea_secdforest(j2,ac_sub))
               + v35_hvarea_primforest(j2)
               + p35_land_restoration(j2,"secdforest")
                 ;

*' Harvested other land is still considered other land

q35_other_regeneration(j2)..
                 sum(ac_est, vm_land_other(j2,"othernat",ac_est))
                 =e=
                 sum((othertype35,ac_sub),v35_hvarea_other(j2,othertype35,ac_sub))
                 + vm_landexpansion(j2,"other")
                 ;

*' The following two constraints distribute additions to secdforest and other land
*' over ac_est, which depends on the time step length (e.g. ac0 and ac5 for a 10 year time step).

q35_secdforest_est(j2,ac_est) ..
v35_secdforest(j2,ac_est) =e= sum(ac_est2, v35_secdforest(j2,ac_est2))/card(ac_est2);

q35_other_est(j2,ac_est) ..
vm_land_other(j2,"othernat",ac_est) =e= sum(ac_est2, vm_land_other(j2,"othernat",ac_est2))/card(ac_est2);

