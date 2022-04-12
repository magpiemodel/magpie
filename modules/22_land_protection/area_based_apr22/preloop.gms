*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* --------------------------------------------------------------------------------------
* Land protection scenarios (based on biodiversity conservation priority areas)
* --------------------------------------------------------------------------------------

* Regional share of land protection policies in selective countries:
* Country switch to determine countries for which land protection shall be applied.
* In the default case, the land protection affects all countries when activated.
p22_country_dummy(iso) = 0;
p22_country_dummy(policy_countries22) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by total land area.
i22_land_iso(iso) = sum(land, f22_land_iso("y1995",iso,land));
p22_country_weight(i) = sum(i_to_iso(i,iso), p22_country_dummy(iso) * i22_land_iso(iso)) / sum(i_to_iso(i,iso), i22_land_iso(iso));

* Derive scenario-dependent land protection share from input data
* This share is then applied proportionally to primary, secondary and other land
p22_protect_shr_ini(j,prot_type_all) = 0;
p22_protect_shr_ini(j,prot_type)$(sum(land_natveg, pm_land_start(j,land_natveg)) > 0) = f22_protect_area(j,prot_type)/sum(land_natveg, pm_land_start(j,land_natveg));

** Trajectory for implementation of land protection
* sigmoidal interpolation between 2020 and target year
m_sigmoid_interpol(p22_protection_fader,2020,s22_protection_target,0,1);

*** WDPA
* No protected area expansion during future time steps
p22_protect_shr(t,j,"WDPA",land_natveg) = 0;

*** Full (1) primary forest protection
p22_protect_shr(t,j,"PrimForest",land_natveg) = 0;
p22_protect_shr(t,j,"PrimForest","primforest") = 1 * p22_protection_fader(t);

*** Full (1) Secondary forest protection
p22_protect_shr(t,j,"SecdForest",land_natveg) = 0;
p22_protect_shr(t,j,"SecdForest","secdforest") = 1 * p22_protection_fader(t);

*** Full (1) forest protection
p22_protect_shr(t,j,"Forest",land_natveg) = 0;
p22_protect_shr(t,j,"Forest","primforest") =  1 * p22_protection_fader(t);
p22_protect_shr(t,j,"Forest","secdforest") = 1 * p22_protection_fader(t);

*** Full (1) forest and other land protection
p22_protect_shr(t,j,"Forest_Other","primforest") = 1 * p22_protection_fader(t);
p22_protect_shr(t,j,"Forest_Other","secdforest") = 1 * p22_protection_fader(t);
p22_protect_shr(t,j,"Forest_Other","other") = 1 * p22_protection_fader(t);

*** Biodiversity hotspots (BH)
p22_protect_shr(t,j,"BH",land_natveg) = p22_protect_shr_ini(j,"BH")*p22_protection_fader(t);

*** Intact forest landscapes (IFL)
p22_protect_shr(t,j,"IFL",land_natveg) = p22_protect_shr_ini(j,"IFL")*p22_protection_fader(t);

*** Centers of plant diversity (CPD)
p22_protect_shr(t,j,"CPD",land_natveg) = p22_protect_shr_ini(j,"CPD")*p22_protection_fader(t);

*** Last of the wild (LW)
p22_protect_shr(t,j,"LW",land_natveg) = p22_protect_shr_ini(j,"LW")*p22_protection_fader(t);

*** Biodiversity Hotspots + Intact Forest Landscapes implementation (BH_IFL)
* Primary forests are fully conserved, while secondary forests are conserved
* according to the Intact Forest Landscape (IFL) data set
* BH_IFL protection mask should only be applied to forest land types. Otherwise area shares
* for other land are overestimated, since IFL only relates to forest protection.
p22_protect_shr(t,j,"BH_IFL","primforest") = 1 * p22_protection_fader(t);
p22_protect_shr(t,j,"BH_IFL","secdforest") = p22_protect_shr_ini(j,"BH_IFL")*p22_protection_fader(t);
p22_protect_shr(t,j,"BH_IFL","other") = p22_protect_shr_ini(j,"BH")*p22_protection_fader(t);

*** HalfEarth
* Note: Half Earth already contains WDPA protection
p22_protect_shr(t,j,"HalfEarth",land_natveg) = p22_protect_shr_ini(j,"HalfEarth")*p22_protection_fader(t);

* Remove implausible values
p22_protect_shr(t,j,prot_type_all,land_natveg)$(p22_protect_shr(t,j,prot_type_all,land_natveg) > 1) = 1;
p22_protect_shr(t,j,prot_type_all,land_natveg)$(p22_protect_shr(t,j,prot_type_all,land_natveg) < 0) = 0;

* -----------------------------------------
* Land protection for climate mitigation
* -----------------------------------------

p22_min_forest(t,j) = f22_min_land_stock(t,j,"%c22_ad_policy%","forest");
p22_min_other(t,j) = f22_min_land_stock(t,j,"%c22_ad_policy%","other");
