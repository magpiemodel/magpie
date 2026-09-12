*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i32_recurring_cost(type32) = s32_recurring_cost;

m_sigmoid_time_interpol(i32_plant_contr_growth_fader,s32_plant_contr_growth_startyear,s32_plant_contr_growth_endyear,s32_plant_contr_growth_startvalue,s32_plant_contr_growth_endvalue);

p32_est_cost("plant") = s32_est_cost_plant;
p32_est_cost("ndc") = s32_est_cost_natveg;
p32_est_cost("aff") = s32_est_cost_natveg$(s32_aff_plantation = 0) + s32_est_cost_plant$(s32_aff_plantation = 1);
** other_planted is harvestable managed forest that replants into itself -> plantation establishment cost.
p32_est_cost("other_planted") = s32_est_cost_plant;

** External per-biome plantation rotation -- the single source of truth for both the cellular
** (establishment/harvest) rotation and the regional (economic) rotation. The plantation carbon curve
** (module 52) describes carbon, not merchantable stem volume, so a silvicultural rotation cannot be derived from it; the
** rotation is instead an explicit management input: f32_plant_rotation (years by Koeppen biome),
** area-weighted per cell and converted to 5-yr age classes. It is time-invariant, so the establishment
** rotation is constant across t_all and the harvesting rotation is identical.

** Number of cells in each region (divisor for the regional rotation average)
p32_ncells(i) = sum(cell(i,j),1);

** Cellular area-weighted external rotation length (years) from the per-biome Koeppen input
p32_plant_rotation_yr(j) = 0;
p32_plant_rotation_yr(j)$(sum(clcl, pm_climate_class(j,clcl)) > 0)
    = sum(clcl, pm_climate_class(j,clcl) * f32_plant_rotation(clcl)) / sum(clcl, pm_climate_class(j,clcl));

** Convert to age-class equivalent (s32_ageclass_length-yr classes), clamped to [1, s32_max_rotation/s32_ageclass_length]
pm_rotation_cellular_estb(t_all,j)       = round(p32_plant_rotation_yr(j)/s32_ageclass_length);
pm_rotation_cellular_estb(t_all,j)$(pm_rotation_cellular_estb(t_all,j) < 1)  = 1;
pm_rotation_cellular_estb(t_all,j)$(pm_rotation_cellular_estb(t_all,j) > s32_max_rotation/s32_ageclass_length) = s32_max_rotation/s32_ageclass_length;

** Harvest rotation equals establishment rotation (time-invariant external rotation)
p32_rotation_cellular_harvesting(t_all,j) = pm_rotation_cellular_estb(t_all,j);

** Representative regional (economic) rotation, derived from the SAME external cellular rotation so
** q32_cost_establishment (equations.gms) and the establishment-demand horizon (presolve.gms) use a
** rotation consistent with the harvest rotation. Age-class-equivalent units (as before).
p32_rotation_regional(t_all,i) = ceil(sum(cell(i,j), pm_rotation_cellular_estb(t_all,j))/p32_ncells(i));

p32_cdr_ac(t,j,ac) = 0;

** Define ini32 set. ac0 is included here. Therefore, initial shifting in presolve.
ini32(j,ac) = no;
ini32(j,ac) = yes$(ord(ac) >= 1 AND ac.off < p32_rotation_cellular_harvesting("y1995",j));

** Set minimum share of plantations in planted forest
p32_plantedforest(i) = f32_plantedforest(i);
p32_plantedforest(i)$(p32_plantedforest(i) < s32_min_plant_shr) = s32_min_plant_shr;

** Split the initial forestry area into timber plantations ("plant", the p32_plantedforest share) and the
** pre-existing other planted forest ("other_planted", the remaining share). Both are harvestable and
** self-replanting. "ndc" and "aff" stay empty at init and fill only via afforestation policies over time
** (q32_aff_pol). Total forestry area and its age distribution are unchanged, so no land input change is needed.
if(s32_initial_distribution = 0,
** Initialize with highest age class
  p32_land_start_ac(j,"plant","acx")         = pcm_land(j,"forestry") * sum(cell(i,j),p32_plantedforest(i));
  p32_land_start_ac(j,"other_planted","acx") = pcm_land(j,"forestry") * sum(cell(i,j),1-p32_plantedforest(i));

elseif s32_initial_distribution = 1,
** Initialize with equal distribution among rotation age classes
  p32_land_start_ac(j,"plant",ac)$(ini32(j,ac))         = pm_land_start(j,"forestry") * sum(cell(i,j),p32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);
  p32_land_start_ac(j,"other_planted",ac)$(ini32(j,ac)) = pm_land_start(j,"forestry") * sum(cell(i,j),1-p32_plantedforest(i))/p32_rotation_cellular_harvesting("y1995",j);

);

** Redistribute any residual (split not fully matching the LUH forestry area) to the youngest
** other-planted age class.
loop(j,
  if(pm_land_start(j,"forestry") > sum((type32,ac),p32_land_start_ac(j,type32,ac)),
    p32_land_start_ac(j,"other_planted","ac0") = p32_land_start_ac(j,"other_planted","ac0") + (pm_land_start(j,"forestry") - sum((type32,ac),p32_land_start_ac(j,type32,ac)));
    );
);

** Safety check: the forestry sub-pools must sum to the total forestry area.
p32_forestry_check = sum((j,type32,ac), p32_land_start_ac(j,type32,ac)) - sum(j, pm_land_start(j,"forestry"));
abort$(abs(p32_forestry_check) > 1e-6) "forestry sub-pool initialisation broke area conservation", p32_forestry_check;

** Initialize forestry land types
pc32_land(j,type32,ac) = p32_land_start_ac(j,type32,ac);

** Provide timber plantation area as interface for module 52 growing stock calibration
pm_land_plantation(j,ac) = pc32_land(j,"plant",ac);

** Afforestation policies NPI and NDCs
p32_aff_pol(t,j) = round(f32_aff_pol(t,j,"%c32_aff_policy%"),6);


*fix bph effect to zero for all age classes except the ac that is chosen for the bph effect to occur after planting (e.g. canopy closure)
*fade-in from ac10 to ac30. First effect in ac10 (ord 3), last effect in ac30 (ord 7).
ac_bph(ac) = no;
ac_bph(ac) = yes$(ord(ac) >= 3 AND ord(ac) <= 7);
display ac_bph;

p32_aff_bgp(j,ac) = 0;
p32_tcre_glo(j) = 0;
if(s32_tcre_local = 1,
  p32_aff_bgp(j,ac_bph) = f32_aff_bgp(j,"%c32_aff_bgp%")/f32_tcre(j,"%c32_tcre_ctrl%")/card(ac_bph);
else
*m_weightedmean returns a global value, which is then used assigned to all j. We use land area as weight.
  p32_tcre_glo(j2) = m_weightedmean(f32_tcre(j,"%c32_tcre_ctrl%"),sum(land, pcm_land(j,land)),j);
  p32_aff_bgp(j,ac_bph) = f32_aff_bgp(j,"%c32_aff_bgp%")/p32_tcre_glo(j)/card(ac_bph);
);

** set bii coefficients
p32_bii_coeff(type32,bii_class_secd,potnatveg) = 0;
if(s32_aff_bii_coeff = 0,
 p32_bii_coeff("aff",bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg)
elseif s32_aff_bii_coeff = 1,
 p32_bii_coeff("aff",bii_class_secd,potnatveg) = fm_bii_coeff("timber",potnatveg)
);
p32_bii_coeff("ndc",bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg);
p32_bii_coeff("plant",bii_class_secd,potnatveg) = fm_bii_coeff("timber",potnatveg);
** other_planted is natveg-curve managed forest -> secondary (natveg) BII coefficient, like ndc.
p32_bii_coeff("other_planted",bii_class_secd,potnatveg) = fm_bii_coeff(bii_class_secd,potnatveg);

* initialize parameter
p32_land(t,j,type32,ac) = 0;

* initialize forest disturbance losses
p32_disturbance_loss_ftype32(t,j,"aff",ac) = 0;

* Initialize biodiversity value
vm_bv.l(j,"aff_co2p",potnatveg) =
  sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), pc32_land(j,"aff",ac)) *
  p32_bii_coeff("aff",bii_class_secd,potnatveg)) * fm_luh2_side_layers(j,potnatveg);

vm_bv.l(j,"aff_ndc",potnatveg) =
  sum(bii_class_secd, (sum(ac_to_bii_class_secd(ac,bii_class_secd), pc32_land(j,"ndc",ac)) *
    p32_bii_coeff("ndc",bii_class_secd,potnatveg)
  + sum(ac_to_bii_class_secd(ac,bii_class_secd), pc32_land(j,"other_planted",ac)) *
    p32_bii_coeff("other_planted",bii_class_secd,potnatveg))) * fm_luh2_side_layers(j,potnatveg);

vm_bv.l(j,"plant",potnatveg) =
  sum(bii_class_secd, sum(ac_to_bii_class_secd(ac,bii_class_secd), pc32_land(j,"plant",ac)) *
  p32_bii_coeff("plant",bii_class_secd,potnatveg)) * fm_luh2_side_layers(j,potnatveg);
