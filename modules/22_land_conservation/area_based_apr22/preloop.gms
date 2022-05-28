*** |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* --------------------------
* Calculate country weights
* --------------------------

* Regional share of land conservation policies in selective countries:
* Country switch to determine countries for which land conservation shall be applied.
* In the default case, the land conservation affects all countries when activated.
p22_country_dummy(iso) = 0;
p22_country_dummy(policy_countries22) = 1;
* Because MAgPIE is not run at country-level, but at region level, a region
* share is calculated that translates the countries' influence to regional level.
* Countries are weighted by total land area.
i22_land_iso(iso) = sum(land, f22_land_iso("y1995",iso,land));
p22_country_weight(i) = sum(i_to_iso(i,iso), p22_country_dummy(iso) * i22_land_iso(iso)) / sum(i_to_iso(i,iso), i22_land_iso(iso));

* ---------------------------------------------------------------------
* Initialise addtional land protection in conservation priority areas
* ---------------------------------------------------------------------

** Trajectory for implementation of land conservation
* sigmoidal interpolation between 2020 and target year
m_sigmoid_interpol(p22_conservation_fader,s22_conservation_start,s22_conservation_target,0,1);

** Initialise additional conservation area
p22_add_consv(t,j,consv22_all,land) = 0;

*** Biodiversity hotspots (BH)
p22_add_consv(t,j,"BH",land) = f22_consv_prio(j,"BH",land)*p22_conservation_fader(t);
*** Intact forest landscapes (IFL)
p22_add_consv(t,j,"IFL",land) = f22_consv_prio(j,"IFL",land)*p22_conservation_fader(t);
*** Centers of plant diversity (CPD)
p22_add_consv(t,j,"CPD",land) = f22_consv_prio(j,"CPD",land)*p22_conservation_fader(t);
*** Last of the wild (LW)
p22_add_consv(t,j,"LW",land) = f22_consv_prio(j,"LW",land)*p22_conservation_fader(t);
*** Biodiversity Hotspots + Intact Forest Landscapes implementation (BH_IFL)
p22_add_consv(t,j,"BH_IFL",land) = f22_consv_prio(j,"BH_IFL",land) * p22_conservation_fader(t);
*** HalfEarth
p22_add_consv(t,j,"HalfEarth",land) = f22_consv_prio(j,"HalfEarth",land)*p22_conservation_fader(t);

